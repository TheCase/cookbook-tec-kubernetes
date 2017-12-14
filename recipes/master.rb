include_recipe 'tec-kubernetes::docker'
include_recipe 'tec-kubernetes::install'



# master services
%w(apiserver controller-manager scheduler).each do |container|
  execute "load/run kube-#{container}" do
    cwd File.join(node['kubernetes']['root'], 'kubernetes/server/bin')
    command "docker load -i ./kube-#{container}.tar && docker run -d gcr.io/google_containers/kube-#{container}:$(cat kube-#{container}.docker_tag)"
    not_if ("docker images | grep #{container}")
  end
end

# etcd
package 'etcd'

service 'etcd' do 
  action [ :enable, :start ]
end

include_recipe 'tec-kubernetes::services'

# api service
directory '/var/lib/kube-apiservice'
#template '/var/lib/kubelet/kubeconfig' do
#  source 'kubelet.config.erb'
#  action :create
#  notifies :restart, 'service[kubelet]'
#end
template '/etc/systemd/system/kube-apiservice.service' do
  source 'kube-apiservice.service.erb'
  notifies :restart, 'service[kube-apiservice]'
end
service 'kube-apiservice' do
  provider Chef::Provider::Service::Systemd
  action [ :enable, :start ]
end
