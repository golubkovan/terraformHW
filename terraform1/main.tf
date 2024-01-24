
locals {
    bucket_name = "tf-intro-site-bucket-agolubkov"
}



//------------Create BuildVM---------------------//
# ресурс "yandex_compute_instance" т.е. сервер
# Terraform будет знаеть его по имени "yandex_compute_instance.build"
resource "yandex_compute_instance" "default" { 
  name = "test-instance"
    allow_stopping_for_update = true
	platform_id = "standard-v1" # тип процессора (Intel Broadwell)

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores  = 2 # vCPU
    memory = 2 # RAM
  }

  boot_disk {
    initialize_params {
      image_id = "fd88m3uah9t47loeseir" # ОС (Ubuntu, 22.04 LTS)
    }
  }

  network_interface {
    subnet_id = "e9besrroes8vu5s5ce0a" # одна из дефолтных подсетей
    nat = true # автоматически установить динамический ip
  }
    metadata = {
    ssh-keys = "agolubkov:${file("~/.ssh/id_rsa.pub")}"
  }
}