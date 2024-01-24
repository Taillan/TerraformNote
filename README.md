# Terraform Guide

## Variable

### variale.tf

```terraform
variable "filename" {
    default = "root/pets.txt"
    type = string
}
```

### interractiv way

```terraform
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

### env var

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

## Terraform Command

```bash
terraform graph
terraform refresh   # Refresh tf state from Real World
terraform validate  # Linter
terraform fmt       # Format in canonical form
terraform providers mirror 
```

## Meta Arguments

### Life Cycle

```terraform
lifecycle {
   prevent_destroy = true
 }
```

```terraform
lifecycle {
   create_before_destroy = true
 }
```

```terraform
lifecycle {
   ignore_changes = [tags]
 }
```

### Depend on

```terraform
depends_on = [
  random_pet.my-pet
]
```

### Count

Will create 3 ressources in a list

```terraform
variable "filename" {
  default = [
    "/root/pets.txt"
    "/root/dogs.txt"
    "/root/cats.txt"
  ]
}

resource "local_file" "pet" {
  filename = var.filename[count.index]
  count = length(var.filename)
}
```

### For each

Create object as a map not a list, allow to update only ressource modify and not change all the list

```terraform
variable "filename" {
  type= list(string)  # or set(string)
  default = [
    "/root/pets.txt"
    "/root/dogs.txt"
    "/root/cats.txt"
  ]
}

resource "local_file" "pet" {
  filename = each.value
  for_each = toset(var.filename) # toset usefull only if its a list not a set
}
```
