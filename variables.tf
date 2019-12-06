variable "create_alb" {
  description = "create alb"
  type = bool
  default = false
}

variable "alb_internal" {
  description = "is alb internal"
  type = bool
  default = false
}

variable "load_balancer_name" {
 description = "name of the alb"
 type = string
 default = ""
}

variable "security_groups" {
  description = "sg for the alb"
  type = list(string)
  default = []
}

variable "subnets" {
  description = "subnets for the alb"
  type = list(string)
  default = []
}

variable "tg_name" {
  description = "target group name"
  type = string
  default = ""
}

variable "vpc_id" {
  description = "id of the vpc"
  type = string
  default = ""
}

variable "target_id" {
  description = "which instances to target"
  type = list(string)
  default = []
}

variable "create" {
  description = "create sg for the alb"
  type = bool
  default = true
}

variable "name" {
  description = "sg name"
  type = string
  default = ""
}

variable "create_ingress_rule" {
  description = "create ingress rule for the alb"
  type = bool
  default = true
}

variable "cidr_blocks" {
  description = "CIDR to allow traffic in"
  type = list(string)
  default = []
}
