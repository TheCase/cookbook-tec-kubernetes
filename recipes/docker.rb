
directory node['docker']['data_dir']

docker_service 'default' do
  host [ "unix:///var/run/docker.sock", "tcp://0.0.0.0:2375" ]
  misc_opts "-g #{node['docker']['data_dir']}"
  insecure_registry node['docker']['insecure_registry']
  action [:create, :start]
end

file '/etc/docker/daemon.json' do
  content <<-EOF
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
EOF
  action :create
end

# allow newrelic user to read docker stats
user 'newrelic'
group 'docker' do
  members [ 'newrelic' ]
end

execute 'install redis logging driver' do
  command 'docker plugin install pressrelations/docker-redis-log-driver:0.0.1 --alias redis-log-driver --grant-all-permissions' 
  action :run
  not_if ('docker plugin list | grep redis')
end
