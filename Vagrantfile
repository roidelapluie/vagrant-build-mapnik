Vagrant::Config.run do |config|
  config.ssh.max_tries = 333

  config.vm.box = "centos6"

  config.vm.share_folder "v-rpms", "/opt/mapnik-rpms", "rpms"

  config.vm.customize do |vm|
    vm.memory_size = 512
    vm.name = "Build Mapnik"
    vm.cpu_count = 2
  end


   config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.module_path = "modules"
     puppet.manifest_file  = "mapnik.pp"
   end

end
