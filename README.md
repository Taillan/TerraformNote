# Terraform Guide

## Variable

### variale.tf

```js
variable "filename" {
    default = "root/pets.txt"
    type = string
}
```

### interractiv way

```js
variable "filename" {
}
```

```bash
terraform apply
var.filename 
  Enter a value: "/root/pets.xt
```

### command line

```bash
terraform appl -var "filename=/root/pets.txt"
```

### ENV VAR

```bash
export TF_VAR_filename="/root/pets.txt"
```

### tfvars

terraform.tfvars

```bash
filename = "/root/pets.txt"
```

if file is named different must use ``-var-file``:

```bash
terraform apply -var-file variables.tfvars
```
