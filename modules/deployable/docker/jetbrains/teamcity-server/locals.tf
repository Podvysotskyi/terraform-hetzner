locals {
  image          = "jetbrains/teamcity-server"
  image_version  = "2025.07.3"
  container_name = "jetbrains-teamcity-server"

  port = 8111
}