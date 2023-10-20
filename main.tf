terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "kafka_disk_io_latency_spike_incident" {
  source    = "./modules/kafka_disk_io_latency_spike_incident"

  providers = {
    shoreline = shoreline
  }
}