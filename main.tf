terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    } 
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.18.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
 provider "postgresql" {
   alias           = "pg1"
   host            = "${docker_container.postgres.name}"
   port            = 5432
   username        = "postgres"
   password        = ""
   sslmode         = "disable"
   connect_timeout = 15
}

resource "docker_image" "postgres" {
  name = "postgres:latest"
}

resource "docker_container" "postgres" {
  image = docker_image.postgres.name
  name = "postgres"
  hostname = "postgres"
}

# resource "postgresql_database" "mutualfunds" {
#   provider = "postgresql.pg1"
#   name     = "testnewdb"
# }

resource "docker_container" "hello_world_app" {
  image = "hello_world_app"
  name  = "hello_world_app"
  restart = "always"

  volumes {
    container_path  = "/myapp"
    host_path = "/home/guarapo/Documents/myapp" 
    read_only = false
  }
  ports {
    internal = 8080
    external = 8080
  }
}

resource "docker_network" "private_network" {
  name = "my_network"
}

