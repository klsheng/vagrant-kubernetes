# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_PROVIDER = "virtualbox"
BOX_RANCHER_RAM_MB = "4096"
BOX_RANCHER_CPU_COUNT = "2"
BOX_NODE_RAM_MB = "2048"
BOX_NODE_CPU_COUNT = "1"

RANCHER_IP = "192.168.33.10"
RANCHER_SERVER = "https://#{RANCHER_IP}"
RANCHER_ADMIN_PASSWORD = "admin1234!"
RANCHER_CLUSTER_NAME = "vg-cluster" # must lower case

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"

  config.vm.define "rancher" do |rancher|
    rancher.vm.hostname = "rancher"
    rancher.vm.network "private_network", ip: RANCHER_IP
	rancher.vm.provider BOX_PROVIDER do |vb|
      vb.memory = BOX_RANCHER_RAM_MB
	  vb.cpus = BOX_RANCHER_CPU_COUNT
    end
	rancher.vm.provision "shell", path: "provision/cleanup-rancher.sh"
	rancher.vm.provision "shell", path: "provision/start-rancher.sh", env: { "RANCHER_ADMIN_PASSWORD" => RANCHER_ADMIN_PASSWORD, "RANCHER_SERVER" => RANCHER_SERVER, "RANCHER_CLUSTER_NAME" => RANCHER_CLUSTER_NAME}
	rancher.vm.provision "shell", path: "provision/register-node.sh", env: { "RANCHER_ADMIN_PASSWORD" => RANCHER_ADMIN_PASSWORD, "RANCHER_SERVER" => RANCHER_SERVER, "NODE_ROLE" => "--etcd --controlplane --worker"}
  end
  
  # config.vm.define "node_core" do |node_core|
    # node_core.vm.hostname = "node-core"
    # node_core.vm.network "private_network", ip: "192.168.33.11"
	# node_core.vm.provider BOX_PROVIDER do |vb|
      # vb.memory = BOX_NODE_RAM_MB
	  # vb.cpus = BOX_NODE_CPU_COUNT
    # end
	# node_core.vm.provision "shell", path: "provision/register-node.sh", env: { "RANCHER_ADMIN_PASSWORD" => RANCHER_ADMIN_PASSWORD, "RANCHER_SERVER" => RANCHER_SERVER, "NODE_ROLE" => "--etcd --controlplane --worker"}
  # end
  
  # config.vm.define "node_worker_1" do |node_worker_1|
    # node_worker_1.vm.hostname = "node-worker-1"
    # node_worker_1.vm.network "private_network", ip: "192.168.33.12"
	# node_worker_1.vm.provider BOX_PROVIDER do |vb|
      # vb.memory = BOX_NODE_RAM_MB
	  # vb.cpus = BOX_NODE_CPU_COUNT
    # end
	# node_worker_1.vm.provision "shell", path: "provision/register-node.sh", env: { "RANCHER_ADMIN_PASSWORD" => RANCHER_ADMIN_PASSWORD, "RANCHER_SERVER" => RANCHER_SERVER, "NODE_ROLE" => "--worker"}
  # end
  
  #config.vm.synced_folder "data", "/vagrant_data"
  config.vm.provision "shell", path: "provision/bootstrap.sh"
  
end
