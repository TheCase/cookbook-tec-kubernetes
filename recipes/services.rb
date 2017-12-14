

# disable swap
include_recipe 'swap_device::disable'

# kubelet service
directory '/var/lib/kubelet'
template '/var/lib/kubelet/kubeconfig' do
  source 'kubelet.config.erb'
  action :create
  notifies :restart, 'service[kubelet]'
end
template '/etc/systemd/system/kubelet.service' do
  source 'kubelet.service.erb'
  notifies :restart, 'service[kubelet]'
end
service 'kubelet' do
  provider Chef::Provider::Service::Systemd
  action [ :enable, :start ]
end

# kubelet-proxy service
directory '/var/lib/kube-proxy' 
template '/var/lib/kube-proxy/kubeconfig' do
  source 'kube-proxy.config.erb'
  action :create
  notifies :restart, 'service[kube-proxy]'
end
template '/etc/systemd/system/kube-proxy.service' do
  source 'kube-proxy.service.erb'
  notifies :restart, 'service[kube-proxy]'
end
service 'kube-proxy' do
  provider Chef::Provider::Service::Systemd
  action [ :enable, :start ]
end
