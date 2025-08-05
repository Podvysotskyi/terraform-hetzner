resource "ssh_resource" "file" {
  host  = var.ssh.host
  user  = var.ssh.user
  port  = var.ssh.port
  agent = true

  when = "create"

  file {
    content     = var.content
    source      = var.path
    destination = var.destination
  }
}