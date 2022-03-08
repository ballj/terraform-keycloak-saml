# Terraform Keycloak SAML

This terraform module creates an SAML client on keycloak.

## Useage

```
module "saml" {
  source        = "ballj/saml/keycloak"
  version       = "~> 1.0"
  realm         = "example.com"
  entity_id     = "https://myapp.example.com/saml"
  name          = "myapp"
}
```

## Variables
 
| Variable                              | Required | Default      | Description                                                      |
| ------------------------------------- | -------- | ------------ | ---------------------------------------------------------------- |
| `name`                                | No       | `null`       | Display name of this client                                      |
| `realm_id`                            | Yes      | N/A          | Realm this client is attached to                                 |
| `entity_id`                           | No       | N/A          | SP Entity ID                                                     |
| `description`                         | No       | `null`       | The description of this client in the GUI                        |
| `enabled`                             | No       | `true`       | Allow clients to initiate a login                                |
| `login_theme`                         | No       | `null`       | Client login theme                                               |
| `include_authn_statement`             | No       | `true`       | AuthnStatement will be included in the SAML response             |
| `sign_documents`                      | No       | `true`       | SAML document will be signed by Keycloak                         |
| `sign_assertions`                     | No       | `false`      | SAML assertions will be signed by Keycloak                       |
| `encrypt_assertions`                  | No       | `false`      | SAML assertions will be encrypted by Keycloak                    |
| `client_signature_required`           | No       | `true`       | Documents originating from a client will be signed               |
| `force_post_binding`                  | No       | `true`       | respond to an authentication request via the SAML POST Binding   |
| `front_channel_logout`                | No       | `true`       | Client will require a browser redirect to perform a logout       |
| `name_id_format`                      | No       | `username`   | Sets the Name ID format for the subject                          |
| `force_name_id_format`                | No       | `false`      | Ignore requested NameID subject format and used configured one   |
| `signature_algorithm`                 | No       | `RSA_SHA256` | The signature algorithm used to sign documents                   |
| `signature_key_name`                  | No       | `KEY_ID`     | Value of the KeyName element within the signed SAML document     |
| `canonicalization_method`             | No       | `EXCLUSIVE`  | The Canonicalization Method for XML signatures                   |
| `root_url`                            | No       | `null`       | URL is prepended to any relative URLs found                      |
| `valid_redirect_uris`                 | No       | `null`       | List of valid URIs                                               |
| `base_url`                            | No       | `null`       | URL to use when the auth server needs to redirect                |
| `master_saml_processing_url`          | No       | `null`       | URL will be used for all SAML requests                           |
| `encryption_certificate`              | No       | `null`       | Certificate that will be used to encrypt client assertions       |
| `signing_certificate`                 | No       | `null`       | Certificate will be used to verify the documents or assertions   |
| `signing_private_key`                 | No       | `null`       | Key will be used to verify the documents or assertions           |
| `idp_initiated_sso_url_name`          | No       | `null`       | URL fragment name to reference client when IDP SSO is enabled    |
| `idp_initiated_sso_relay_state`       | No       | `null`       | Relay state you want to send with SAML request SSO is enabled    |
| `assertion_consumer_post_url`         | No       | `null`       | POST Binding URL for the client's assertion consumer service     |
| `assertion_consumer_redirect_url`     | No       | `null`       | Redirect Binding URL for the client's assertion consumer service |
| `logout_service_post_binding_url`     | No       | `null`       | SAML POST Binding URL for the client's single logout service     |
| `logout_service_redirect_binding_url` | No       | `null`       | SAML Redirect Binding URL for the client's single logout service |
| `full_scope_allowed`                  | No       | `false`      | Allow to include all roles mappings in the token                 |
| `roles`                               | No       | `[]`         | Roles to add to client                                           |
| `user_property_protocol_mappers`      | No       | `[]`         | User-property protocol mappers to add to client                  |
| `role_list_mapper`                    | No       | `[]`         | Role-List mapper to add to the client                            |
| `keys_filter_algorithm`               | No       | `[]`         | Keys will be filtered by algorithm                               |
| `keys_filter_status`                  | No       | `["ACTIVE"]` | Keys will be filtered by status                                  |

## Roles

A list of roles and associated group mappings can be passed to the moduule:

```
module "openid" {
  role = [
    {
      name        = "admin",
      description = "Admin role"
      group       = "Admins"
    }
  ]
}
```

## Role Mappers

### User Property role mapper

User property role mappers can be configured by passing a list to `user_property_protocol_mappers`.
The variables can be found in the TF [saml_user_property_protocol_mapper](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/saml_user_property_protocol_mapper).

```
module "saml" {
  user_property_protocol_mappers = [
    {
      name                       = "X500 email"
      user_property              = "email"
      friendly_name              = "email"
      saml_attribute_name        = "Email"
      saml_attribute_name_format = "Unspecified"
    }
}
```

### Role-List mapper

Role-list role mappers can be configured by configuring the variable `role_list_mapper`.
The following attributes can be used:

```
module "saml" {
  role_list_mapper = {
    name = "role-list"
    saml_attribute_name = "Roles"
    friendly_name = "Roles"
    saml_attribute_name_format = "Basic"
    single_role_attribute = false
  }
}
```
