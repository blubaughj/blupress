Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "web" do |web|
    web.vm.box = "generic/ubuntu1804"
    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.provision "file", source: "variables.sh", destination: "/tmp/variables.sh"
    web.vm.provision "shell", path: "web.sh"
    web.vm.provider :virtualbox do |vb|
      vb.customize [
        "modifyvm", :id,
        "--cpuexecutioncap", "25",
        "--memory", "512",
      ]
    end
  end

  config.vm.define "db" do |db|
    db.vm.box = "generic/ubuntu1804"
    db.vm.provision "file", source: "variables.sh", destination: "/tmp/variables.sh"
    db.vm.provision "shell", path: "db.sh"
    db.vm.provider :virtualbox do |vb|
      vb.customize [
        "modifyvm", :id,
        "--cpuexecutioncap", "25",
        "--memory", "512",
      ]
    end
  end
end
