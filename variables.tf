variable "realm" {
  type        = string
  description = "Realm this client is attached to"
}

variable "entity_id" {
  type        = string
  description = "SP Entity ID"
  default     = ""
}

variable "name" {
  type        = string
  description = "Display name of this client"
  default     = null
}

variable "description" {
  type        = string
  description = "The description of this client in the GUI"
  default     = null
}

variable "enabled" {
  type        = bool
  description = "Allow clients to initiate a login or obtain access tokens"
  default     = true
}

variable "login_theme" {
  type        = string
  description = "Client login theme"
  default     = null
}

variable "include_authn_statement" {
  type        = bool
  description = "AuthnStatement will be included in the SAML response"
  default     = true
}

variable "sign_documents" {
  type        = bool
  description = "SAML document will be signed by Keycloak using the realm's private key"
  default     = true
}

variable "sign_assertions" {
  type        = bool
  description = "SAML assertions will be signed by Keycloak using the realm's private key"
  default     = false
}

variable "encrypt_assertions" {
  type        = bool
  description = "SAML assertions will be encrypted by Keycloak using the client's public key"
  default     = false
}

variable "client_signature_required" {
  type        = bool
  description = "Keycloak will expect that documents originating from a client will be signed"
  default     = true
}

variable "force_post_binding" {
  type        = bool
  description = "Keycloak will always respond to an authentication request via the SAML POST Binding"
  default     = true
}

variable "front_channel_logout" {
  type        = bool
  description = "Client will require a browser redirect in order to perform a logout"
  default     = true
}

variable "name_id_format" {
  type        = string
  description = "Sets the Name ID format for the subject"
  default     = "username"
  validation {
    condition     = contains(["username", "email", "transient", "persistent"], var.name_id_format)
    error_message = "Must be one of username, email, transient, persistent."
  }
}

variable "force_name_id_format" {
  type        = bool
  description = "Ignore requested NameID subject format and used configured one"
  default     = false
}

variable "signature_algorithm" {
  type        = string
  description = "The signature algorithm used to sign documents"
  default     = "RSA_SHA256"
  validation {
    condition     = contains(["RSA_SHA1", "RSA_SHA256", "RSA_SHA512", "DSA_SHA1"], var.signature_algorithm)
    error_message = "Must be one of RSA_SHA1, RSA_SHA256, RSA_SHA512 or DSA_SHA1."
  }
}

variable "signature_key_name" {
  type        = string
  description = "Value of the KeyName element within the signed SAML document"
  default     = "KEY_ID"
  validation {
    condition     = contains(["NONE", "KEY_ID", "CERT_SUBJECT"], var.signature_key_name)
    error_message = "Must be one of NONE, KEY_ID or CERT_SUBJECT."
  }
}

variable "canonicalization_method" {
  type        = string
  description = "The Canonicalization Method for XML signatures"
  default     = "EXCLUSIVE"
  validation {
    condition     = contains(["EXCLUSIVE", "EXCLUSIVE_WITH_COMMENTS", "INCLUSIVE", "INCLUSIVE_WITH_COMMENTS"], var.canonicalization_method)
    error_message = "Must be one of EXCLUSIVE, EXCLUSIVE_WITH_COMMENTS, INCLUSIVE or INCLUSIVE_WITH_COMMENTS."
  }
}

variable "root_url" {
  type        = string
  description = "URL is prepended to any relative URLs found"
  default     = null
}

variable "valid_redirect_uris" {
  type        = list(string)
  description = "List of valid URIs a browser is permitted to redirect to after a successful login or logout"
  default     = null
}

variable "base_url" {
  type        = string
  description = "Default URL to use when the auth server needs to redirect or link back to the client"
  default     = null
}

variable "master_saml_processing_url" {
  type        = string
  description = "URL will be used for all SAML requests"
  default     = null
}

variable "encryption_certificate" {
  type        = string
  description = "Certificate that will be used to encrypt client assertions"
  default     = null
}

variable "signing_certificate" {
  type        = string
  description = "Certificate will be used to verify the documents or assertions from the client"
  default     = null
}

variable "signing_private_key" {
  type        = string
  description = "Key will be used to verify the documents or assertions from the client"
  default     = null
}

variable "idp_initiated_sso_url_name" {
  type        = string
  description = "URL fragment name to reference client when you want to do IDP Initiated SSO"
  default     = null
}

variable "idp_initiated_sso_relay_state" {
  type        = string
  description = "Relay state you want to send with SAML request when you want to do IDP Initiated SSO"
  default     = null
}

variable "assertion_consumer_post_url" {
  type        = string
  description = "SAML POST Binding URL for the client's assertion consumer service"
  default     = null
}

variable "assertion_consumer_redirect_url" {
  type        = string
  description = "SAML Redirect Binding URL for the client's assertion consumer service"
  default     = null
}

variable "logout_service_post_binding_url" {
  type        = string
  description = "SAML POST Binding URL for the client's single logout service"
  default     = null
}

variable "logout_service_redirect_binding_url" {
  type        = string
  description = "SAML Redirect Binding URL for the client's single logout service"
  default     = null
}

variable "full_scope_allowed" {
  type        = bool
  description = "Allow to include all roles mappings in the access token"
  default     = false
}

variable "roles" {
  type        = list(any)
  description = "Roles to add to client"
  default     = []
}

variable "user_property_protocol_mappers" {
  type        = list(any)
  description = "User-property protocol mappers to add to client"
  default     = []
}

variable "keys_filter_algorithm" {
  type        = list(string)
  description = "Keys will be filtered by algorithm"
  default     = []
}

variable "keys_filter_status" {
  type        = list(string)
  description = "Keys will be filtered by status"
  default     = ["ACTIVE"]
}

variable "role_list_mapper" {
  type        = map(any)
  description = "Role-List mapper to add to the client"
  default     = null
}
