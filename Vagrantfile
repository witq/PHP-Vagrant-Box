# -*- mode: ruby -*-
# vi: set ft=ruby :

vagrant_settings = File.expand_path("../Vagrantsettings", __FILE__)
load vagrant_settings

#vagrant_command_composer = File.expand_path("../commands/composer.rb", __FILE__)
#load vagrant_command_composer
#vagrant_command_console = File.expand_path("../commands/console.rb", __FILE__)
#load vagrant_command_console

Vagrant.configure("2") do |vagrant_config|
    vagrant_config.vm.define :symfony do |config|
        config.vm.box = $base_box
        config.vm.box_url = $base_box_url

        config.vm.hostname = $vhost

        config.vm.network "private_network", ip: $ip

        config.vm.network "forwarded_port", guest: 80, host: 8880 #Apache
        config.vm.network "forwarded_port", guest: 3306, host: 8886 #MySQL

        config.vm.synced_folder "./", "/var/www", id: "www", nfs: $use_nfs

        config.vm.provider :virtualbox do |virtualbox|
            virtualbox.customize ["modifyvm", :id, "--name", $vhost]
            virtualbox.customize ["modifyvm", :id, "--memory", $memory_size]
        end

        config.vm.provision "shell", inline: "echo \"Europe/Moskow\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        config.vm.provision "puppet" do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "phpbase.pp"
            puppet.module_path = "puppet/modules"
            puppet.facter = {
                "vhost" => $vhost,
                "app_env" => $app_env,
                "app_debug" => $app_debug
            }
        end

        config.vm.provision "shell", path: "puppet/scripts/enable_remote_mysql_access.sh"
    end
end
