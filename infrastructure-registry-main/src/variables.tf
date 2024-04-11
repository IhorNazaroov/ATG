variable "client_name" {
  description = "Client name"
  default     = "infraregistry"
}

variable "env" {
  default = "dev"
}

variable "node_count" {
  description = "Default number of node count"
  default     = 2
}

variable "instance_type" {
  default = "t3a.small"
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will be created in"
  type        = list(any)
  default     = ["subnet-05f9547ab81a84464", "subnet-000d9a864c29049a7"]
}

variable "ami_id" {
  description = "The AMI to use"
  default     = "ami-002c09e4f1710031a"
}

variable "ami_key_pair_name" {
  default = "eqhosting-key"
}

variable "security_group_ids" {
  type    = list(any)
  default = ["sg-06e68a79ca4ded9bf"]
}

variable "iam_role" {
  default = "Edalex_App_Server_Role"
}

variable "alarm_sns" {
  default = "arn:aws:sns:ap-southeast-2:518133925490:AWSCloudwatchProdEmailAlarms"
}

variable "fsx_hostname" {
  description = "FSx Server hostname"
  default     = "fsx.aws.edalex.com"
}

variable "region" {
  default = "ap-southeast-2"
}

variable "client_user_data" {
  description = "Additional user-data for client specific configuration"
  default = ""
}

variable "internal_ips" {
  description = "EC2 Internal IPs"
}
