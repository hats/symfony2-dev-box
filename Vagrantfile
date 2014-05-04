# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::configure("2") do |config|

 config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", "1024",
      "--cpus", "2",
      "--ioapic", "on"
      ]
    end

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "devbox"
  config.vm.synced_folder "www", "/var/www", nfs: { 
    mount_options: ['dmode=777,fmode=777'] 
  }
  # config.vm.synced_folder "www", "/var/www"

  # Set the Timezone to something useful
  config.vm.provision :shell, inline: "echo \"Europe/Moscow\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.

  config.vm.network :private_network, ip: "192.168.3.3"
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules;
		    puppet module install willdurand/nodejs"
  end

  config.vm.provision :puppet do |puppet|
     puppet.facter = { fqdn: "local.devbox", hostname: "devbox" }
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path = "modules"
  end
end
