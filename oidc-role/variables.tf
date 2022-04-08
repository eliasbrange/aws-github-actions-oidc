variable "name" {
  type = string
}

variable "subject_claims" {
  type = list(string)
}

variable "oidc_provider_arn" {
  type = string
}

variable "policy" {
  type = string
}
