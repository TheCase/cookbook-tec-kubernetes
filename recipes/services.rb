

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

# services
%w(kubelet kube-proxy).each do |svc|
  directory "/var/lib/#{svc}"
  template "/var/lib/#{svc}/kubeconfig" do
    source "#{svc}.config.erb"
    action :create
    notifies :restart, "service[#{svc}]"
  end
  template "/etc/systemd/system/#{svc}.service" do
    source "#{svc}.service.erb"
    variables ({ 
      :service => svc,
      :args    => node['kubernetes']['args'][svc],
      :after   => node['kubernetes']['after'][svc]
    })
    notifies :restart, "service[#{svc}]"
  end
  service svc do
    provider Chef::Provider::Service::Systemd
    action [ :enable, :start ]
  end
end
