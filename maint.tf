provider "google" {
  project     = "playground-s-11-f89dd61a"
  region      = "us-east1"
}

//command to add compute instance

resource "google_compute_instance" "demo" {
    
    machine_type = "e2-micro"
    name = "web-${count.index}"
    zone = "us-east1-b"
    count = 1

attached_disk {
  source = google_compute_disk.default.id
}

attached_disk {
  source = google_compute_disk.disk2.id
}
    network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }

     
  }
  


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
}

// set output variable


output "instance_ip_addr" {
  value = google_compute_instance.demo.*.network_interface.0.access_config.0.nat_ip
}

//create additonal disk

resource "google_compute_disk" "default" {
  name  = "data"
  zone = "us-east1-b"
  size = 10
}

resource "google_compute_disk" "disk2" {
  name  = "database"
  zone = "us-east1-b"
  size = 10
}
