
locals {
    bucket_name = "tf-intro-site-bucket-agolubkov"
}



//------------Create BuildVM---------------------//

resource "yandex_compute_instance" "build-vm" {
  name = "build-vm"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 2
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
#-------Connect to Vm build---------#
connection {
    type     = "ssh"
    user     = "agolubkov"
    private_key = file("~/.ssh/id_rsa")
    host = yandex_compute_instance.build-vm.network_interface.0.nat_ip_address
  }
#-------/Connect to Vm build---------#

  provisioner "file" {
    source      = "dockerfile"
    destination = "/tmp/dockerfile"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt update", 
      "sudo apt install docker.io -y",
      "mkdir ~/tomcat_box",
      "cp /tmp/dockerfile ~/tomcat_box/",
      "cd ~/tomcat_box/",
      "sudo docker build -t tomcat_box .",
      "sudo docker tag tomcat_box agolubkov/tomcat_box",
      "sudo docker tag tomcat_box cr.yandex/${yandex_container_registry.agolubkovreg.id}/tomcat_box",
      "sudo docker push cr.yandex/${yandex_container_registry.agolubkovreg.id}/tomcat_box"

    ]
  }
}