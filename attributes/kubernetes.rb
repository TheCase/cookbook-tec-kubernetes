default['kubernetes']['root'] = '/opt'
default['kubernetes']['version'] = '1.8.5'
default['kubernetes']['checksum'] = '7a7993e5dee72ede890e180112959a1fe179b592178ef24d04c48212c09345b8'
default['kubernetes']['url'] = "https://github.com/kubernetes/kubernetes/releases/download/v#{node['kubernetes']['version']}/kubernetes.tar.gz"
