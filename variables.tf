variable "cidr_blocks" {
    description = "cidr block for network configuration"
    type = list(object({
        cidr_block = string,
        name = string
    }))
}

variable "env" {
    description = "Environment of vpc"
}