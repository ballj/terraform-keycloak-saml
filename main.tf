terraform {
  required_version = ">= 0.12.0"
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.6.0"
    }
  }
}

data "keycloak_realm" "main" {
  realm = var.realm
}

data "keycloak_realm_keys" "main" {
  realm_id   = data.keycloak_realm.main.id
  algorithms = var.keys_filter_algorithm
  status     = var.keys_filter_status
}

data "keycloak_group" "main" {
  for_each = toset([for role in var.roles : role.group])
  realm_id = data.keycloak_realm.main.id
  name     = each.key
}

resource "keycloak_saml_client" "main" {
  realm_id  = data.keycloak_realm.main.id
  client_id = var.entity_id

  name        = var.name
  description = var.description
  enabled     = var.enabled

  root_url            = var.root_url
  base_url            = var.base_url
  valid_redirect_uris = var.valid_redirect_uris
  login_theme         = var.login_theme
  full_scope_allowed  = var.full_scope_allowed

  include_authn_statement = var.include_authn_statement

  sign_documents     = var.sign_documents
  sign_assertions    = var.sign_assertions
  encrypt_assertions = var.encrypt_assertions

  client_signature_required = var.client_signature_required
  force_post_binding        = var.force_post_binding
  front_channel_logout      = var.front_channel_logout

  name_id_format       = var.name_id_format
  force_name_id_format = var.force_name_id_format

  signature_algorithm     = var.signature_algorithm
  signature_key_name      = var.signature_key_name
  canonicalization_method = var.canonicalization_method

  encryption_certificate = var.encryption_certificate
  signing_certificate    = var.signing_certificate
  signing_private_key    = var.signing_private_key

  idp_initiated_sso_url_name    = var.idp_initiated_sso_url_name
  idp_initiated_sso_relay_state = var.idp_initiated_sso_relay_state

  master_saml_processing_url          = var.master_saml_processing_url
  assertion_consumer_post_url         = var.assertion_consumer_post_url
  assertion_consumer_redirect_url     = var.assertion_consumer_redirect_url
  logout_service_post_binding_url     = var.logout_service_post_binding_url
  logout_service_redirect_binding_url = var.logout_service_redirect_binding_url
}

resource "keycloak_role" "main" {
  for_each        = { for role in var.roles : role.name => role }
  realm_id        = data.keycloak_realm.main.id
  client_id       = keycloak_saml_client.main.id
  name            = each.key
  description     = lookup(each.value, "description", null)
  composite_roles = lookup(each.value, "composite_roles", null)
  attributes      = lookup(each.value, "attributes", {})
}

resource "keycloak_saml_user_property_protocol_mapper" "main" {
  for_each  = { for user_property in var.user_property_protocol_mappers : user_property.name => user_property }
  realm_id  = data.keycloak_realm.main.id
  client_id = keycloak_saml_client.main.id
  name      = each.key

  user_property              = each.value.user_property
  friendly_name              = lookup(each.value, "friendly_name", null)
  saml_attribute_name        = each.value.saml_attribute_name
  saml_attribute_name_format = lookup(each.value, "saml_attribute_name_format", "Unspecified")
}

resource "keycloak_group_roles" "main" {
  for_each = { for role in var.roles : role.name => role }
  realm_id = data.keycloak_realm.main.id
  group_id = data.keycloak_group.main[each.value.group].id

  role_ids = [
    keycloak_role.main[each.key].id
  ]
}
