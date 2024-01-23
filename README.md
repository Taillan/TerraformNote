## Variable

*variale.tf*

```js
variable "filename" {
    default = "root/pets.txt"
    type = string
}
```

*interractiv way*

```js
variable "filename" {
}
```

```bash
terraform apply
var.filename 
  Enter a value: "/root/pets.xt
```

*command line*

```bash
terraform appl -var "filename=/root/pets.txt
```
