include_recipe 'tec-kubernetes::docker'
include_recipe 'tec-kubernetes::install'

# etcd
package 'etcd'

service 'etcd' do 
  action [ :enable, :start ]
end

# services
%w(kube-apiserver kube-controller-manager kube-scheduler).each do |svc|
  directory "/var/lib/#{svc}"
  template "/etc/systemd/system/#{svc}.service" do
    source 'kube.service.erb'
    variables ({ 
      :service => svc,
      :args    => node['kubernetes'][svc]['args'],
      :after   => node['kubernetes'][svc]['after']
    })
    notifies :restart, "service[#{svc}]"
  end
  service #{svc} do
    provider Chef::Provider::Service::Systemd
    action [ :enable, :start ]
  end
end

include_recipe 'tec-kubernetes::services'
