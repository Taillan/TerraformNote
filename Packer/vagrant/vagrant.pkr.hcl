packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "example" {
  communicator = "ssh"
  source_path = "hashicorp/precise64"
  provider = "virtualbox"
  add_force = true
}

build {
  sources = ["source.vagrant.example"]
}