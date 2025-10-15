locals {
  image          = "jetbrains/hub"
  image_version  = "2025.2.100871"
  container_name = "jetbrains-hub"
  network_name   = "jetbrains"

  port = 8080
}