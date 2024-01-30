packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}


# Variable Definitions
variable "proxmox_api_url" {
  type    = string
  default = "https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso"
}

variable "proxmox_api_token_id" {
  type    = string
  default = "packer"
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
  default   = "d116086b-6714-41f7-add3-5f1a68a4b952"
}


source "proxmox-iso" "ubuntu-example" {
  proxmox_url              = "${var.proxmox_api_url}"
  username                 = "${var.proxmox_api_token_id}"
  token                    = "${var.proxmox_api_token_secret}"
  insecure_skip_tls_verify = true

  # VM General Settings
  node                 = "pve" # add your proxmox node
  vm_id                = "100"
  vm_name              = "ubuntu-server-focal-docker"
  template_description = "Ubuntu Server Focal Image with Docker pre-installed"


  iso_url          = "https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso"
  iso_checksum     = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_storage_pool = "local"
  unmount_iso      = true


  # VM System Settings
  qemu_agent = true

  disks {
    disk_size         = "20G"
    format            = "qcow2"
    storage_pool      = "local-lvm"
    storage_pool_type = "lvm"
    type              = "virtio"
  }

  # VM CPU Settings
  cores = "1"

  # VM Memory Settings
  memory = "2048"

  # VM Network Settings
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = "false"
  }

  # VM Cloud-Init Settings
  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  # PACKER Boot Commands
  boot_command = [
    "<esc><wait><esc><wait>",
    "<f6><wait><esc><wait>",
    "<bs><bs><bs><bs><bs>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "--- <enter>"
  ]
  boot      = "c"
  boot_wait = "5s"

  # PACKER Autoinstall Settings
  http_directory = "http"
  # (Optional) Bind IP Address and Port
  # http_bind_address = "192.168.1.110"
  # http_port_min = 8802
  # http_port_max = 8802

  ssh_username = "root"

  # (Option 1) Add your Password here
  ssh_password = "root"
  # - or -
  # (Option 2) Add your Private SSH KEY file here
  # ssh_private_key_file = "~/.ssh/id_rsa"

  # Raise the timeout, when installation takes longer
  ssh_timeout = "20m"
}

build {
  name    = "ubuntu-server-focal-docker"
  sources = ["sources.proxmox-iso.ubuntu-example"]
}