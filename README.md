## Variable

*variale.tf*

```json
variable "filename" {
    default = "root/pets.txt"
    type = string
}
```
*interractiv way*

```json
variable "filename" {
}
```

```bash
terraform appl 
var.filename 
  Enter a value: "/root/pets.xt
```

*command line*

```bash
terraform appl -var "filename=/root/pets.txt
```
