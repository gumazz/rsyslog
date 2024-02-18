Vagrant.configure("2") do |config|
  # Base VM OS configuration.
  config.vm.box = "centos/7"
  config.vm.box_version = "2004.01"

  config.vm.provider :virtualbox do |v|
    v.memory = 512
    v.cpus = 1
  end

  # Define two VMs with static private IP addresses.
  boxes = [
    { :name => "web",
      :ip => "192.168.50.10",
      :provision => "web.sh",
    },
    { :name => "log",
      :ip => "192.168.50.15",
      :provision => "log.sh",
    }
  ]
  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network "private_network", ip: opts[:ip]
      config.vm.provision "shell", path: opts[:provision]
    end
  end
end
