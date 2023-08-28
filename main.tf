terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.65.0"
    }
  } 
}
provider "yandex" { #Авторизация на провайдере
  token     = "y0_AgAAAAA*****JG-eaUs"
  cloud_id  = "b1g4a*****3fgb0"
  folder_id = "b1gb*****mo7"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "mynetwork-001" { #Создаю сеть
  name = "mynetwork-001"
}

resource "yandex_vpc_subnet" "subnet" { #Подсеть
  name           = "subnet01"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.mynetwork-001.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

module "swarm_cluster" { #Подключаю модуль
  source        = "./modules"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  managers      = 1
  workers       = 2
}
