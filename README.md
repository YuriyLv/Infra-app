# Terraform

## Getting started

To start add on setting two value:
```
variable "access_key" {

  description = "Enter your access key"
  type        = string
  default     = "AAAAAAAAAAAAAAAAAAAA"                 
}

variable "secret_key" {

  description = "Enter your secret key"
  type        = string
  default     = "BBBBbbbbbBBBBBBBBBBBbbbbbBBBBBBBBBBbbbBb"
                 
}
```

## outputs

```
bastion_ip:         ${публічна ІР бастіона}
ci_cd_ip:           ${приватна ІР СІ/CD інстанса}
rds_enpoint:        ${ендпоінт RDS інстанса}
database_name:      ${імя бази даних}
database_username:  ${user до бази даних}
database_password:  ${пароль до бази даних}
```
