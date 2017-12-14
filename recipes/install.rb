
directory node['kubernetes']['root']
kube_dir = File.join( node['kubernetes']['root'], 'kubernetes')

log("artifact: #{node['kubernetes']['url']}")

# untar artifact
poise_archive node['kubernetes']['url'] do
  destination kube_dir
  action :unpack
end

execute 'install binaries' do 
  cwd File.join( kube_dir, 'cluster' )
  command 'yes | ./get-kube-binaries.sh'
  not_if { ::File.exist?( File.join( kube_dir, 'client', 'bin', 'kubectl' )) }
end 
 
# untar server
srv_tar = File.join(kube_dir, 'server', 'kubernetes-server-linux-amd64.tar.gz' ) 
execute 'unpack server' do
  cwd node['kubernetes']['root']
  command "tar -zxf #{srv_tar}"
  action :run
  not_if { ::File.exist?( File.join( kube_dir, 'server', 'bin', 'kubectl' )) }
end

