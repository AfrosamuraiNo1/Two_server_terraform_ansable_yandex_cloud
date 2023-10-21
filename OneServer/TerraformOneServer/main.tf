terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAABxd_yIAATuwQAAAADvUBPa-hrDRed3ScCYxm-Cu8Ezz9-Ekhs"
  cloud_id  = "b1gkp4p2fc5m4tk4mv23"
  folder_id = "b1gk91seujvu5ushi47l"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "my-ubuntu-2004-1" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "my-vm-1" {
  name        = "test-vm-1"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.my-ubuntu-2004-1.id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.my-sn-1.id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "my-nw-1" {
  name = "my-nw-1"
}

resource "yandex_vpc_subnet" "my-sn-1" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my-nw-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.my-vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.my-vm-1.network_interface.0.nat_ip_address
}
