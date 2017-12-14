
default['kubernetes'] = {
  'kubelet' = {
    :args => '--logtostderr=true -v=2 --allow-privileged=true --kubeconfig=/var/lib/kubelet/kubeconfig --cgroup-driver=cgroupfs',
    :after => 'docker.service'
 },
 'kube-proxy' = {
   :args     => '--master=http://127.0.0.1:8080',
   :after => 'kube-apiserver.service'
 },
 'apiserver' = { 
   :args => '--insecure-bind-address=127.0.0.1 --etcd-servers=http://127.0.0.1:2379,http://127.0.0.1:4001 --service-cluster-ip-range=10.254.0.0/16 --admission-control=NamespaceLifecycle,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota',
   'after' => 'kube-controller-manager.service'
 },
 'kube-controller-manager' {
   :args => '',
   :after => 'docker.service'
 },
 'kube-scheduler' {
   :args => '',
   :after => 'docker.service'
 }
}
