
locals {
    bucket_name = "tf-intro-site-bucket-agolubkov"
}

//------------Create BuildVM---------------------//

resource "yandex_compute_instance" "default" { 
  name = "BuildVM"
    allow_stopping_for_update = true
	platform_id = "standard-v1" 

  resources {
    core_fraction = 5 
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
    user-data = "${file("/mnt/c/Users/golubkovan/VsCode/terraformHW/terraform1/meta.txt")}"
  }
}