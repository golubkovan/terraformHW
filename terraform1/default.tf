terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  folder_id = "b1gs0pm6ll8cf737ur0d"
  cloud_id = "b1gn49oi728vfl0b0e11"
}

provider "yandex" {
  service_account_key_file = "/home/agolubkov/authorized_key.json"
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  zone                     = "ru-central1-a"
}