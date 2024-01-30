packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-ovf" "basic-example" {
  source_path      = "Packer.ova"
  ssh_username     = "packer"
  ssh_password     = "packer"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--memory", "1024"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"]
  ]
}

build {
  sources = ["sources.virtualbox-ovf.basic-example"]

  provisioner "shell" {
    execute_command= "echo 'packer' | {{.Vars}} sudo -S -E sh -eux '{{.Path}}'"
    script = "install_nginx.sh"
  }

  provisioner "shell" {
    inline = ["systemctl status nginx"]
  }

}
