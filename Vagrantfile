INSTANCE_PREFIX="kube"

$num_instance = 3
#$box = "ubuntu/trusty64"
#$box = "ubuntu/xenial64"
$box = "boxcutter/ubuntu1604"

$vm_cpus = 2
$vm_memory = 1024

Vagrant.configure("2") do |config|

  def customize(config)
    config.vm.box = $box
    config.ssh.insert_key = false
    #config.ssh.username = "vagrant"
    #config.ssh.password = "vagrant"
    config.ssh.forward_agent = true
    config.ssh.forward_x11 = true
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", $vm_memory]
      vb.customize ["modifyvm", :id, "--cpus", $vm_cpus]
      vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
    end
  end

  $num_instance.times do |i|
    config.vm.define "#{INSTANCE_PREFIX}-#{i+1}" do |target|
      customize target
      instance_index = i+1

      target.vm.provider :virtualbox do |vb|
        vb.name = "#{INSTANCE_PREFIX}-#{instance_index}"
      end 

      target.vm.hostname= "#{INSTANCE_PREFIX}-#{instance_index}.local.io"
      target.landrush.enabled = true
      target.landrush.tld = "local.io"
      target.vm.provision :shell, path: "bootstrap.sh"
    end
  end

  config.landrush.host 'etcd.local.io', '172.28.128.3'
  config.landrush.host 'kube-apiserver.local.io', '172.28.128.3'
  config.landrush.host 'laptop.local.io', '172.28.128.1'
end
