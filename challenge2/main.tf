resource "docker_image" "php-httpd-image" {
    name="php-httpd:challenge"
    build{
        path = "lamp_stack/php_httpd"
        label = {
            challenge = "second"
        }
    }
}

resource "docker_image" "mariadb-image" {
    name="mariadb:challenge"
    build{
        path = "lamp_stack/custom_db"
        label = {
            challenge = "second"
        }
    }
}

resource "docker_container" "php-httpd" {
  name  = "webserver"
  hostname = "php-httpd"
  image = "php-httpd:challenge"
  networks = ["my_network"]
  ports  {
    external = 80
    ip = "0.0.0.0"
    internal=80
  }
  labels  {
    label="challenge"
    value="second"
  }
  volumes {
    container_path = "/var/www/html"
    host_path ="/root/code/terraform-challenges/challenge2/lamp_stack/website_content/"
  }
}
resource "docker_container" "phpmyadmin" {
  name  = "db_dashboard"
  image = "phpmyadmin/phpmyadmin"
  hostname = "phpmyadmin"
  networks = ["my_network"]
  ports  {
    external =8081
    ip = "0.0.0.0"
    internal=80
  }
  labels  {
    label="challenge"
    value="second"
  }
  links = ["db"]
  depends_on = [ docker_container.mariadb ]
}
resource "docker_container" "mariadb" {
  name  = "db"
  image = "mariadb:challenge"
  hostname = "db"
  networks = ["my_network"]
  ports  {
    external =3306
    ip = "0.0.0.0"
    internal=3306
  }
  labels {
    label="challenge"
    value="second"
  }
  env=["MYSQL_ROOT_PASSWORD=1234","MYSQL_DATABASE=simple-website"]
  volumes {
    volume_name="mariadb-volume"
    container_path="/var/lib/mysql"
  }
}
resource "docker_network" "private_network" {
  name = "my_network"
  attachable= true
  labels {
    label="challenge"
    value="second"
  }
}

resource "docker_volume" "mariadb_volume" {
  name="mariadb-volume"
}