Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vbox|
    vbox.name = "phoenix"
  end
  config.vm.box = "ubuntu-15.04"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/xenial64/versions/20160521.0.0/providers/virtualbox.box"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "sync", "/home/vagrant/sync"
  config.vm.provision "shell", path: "initialize.sh"
end
