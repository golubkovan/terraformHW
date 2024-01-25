resource "yandex_container_registry" "agolubkovreg" {
  name = "agolubkovreg"
  folder_id = local.folder_id
  labels = {
    my-label = "agolubkovreg1"
  }
}
resource "yandex_container_registry_iam_binding" "puller" {
  registry_id = yandex_container_registry.agolubkovreg.id
  role        = "container-registry.images.puller"
  members = [
    "system:allUsers",
  ]
}
resource "yandex_container_registry_iam_binding" "pusher" {
  registry_id = yandex_container_registry.agolubkovreg.id
  role        = "container-registry.images.pusher"
  members = [
    "system:allUsers",
  ]
}