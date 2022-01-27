output "roles" {
  value = { for role in keycloak_role.main : role.name => role.id }
}

output "realm_keys" {
  value = data.keycloak_realm_keys.main.keys
}
