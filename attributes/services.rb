
default['kubernetes']['args'] = {
 :kubelet   => '--logtostderr=true -v=2 --allow-privileged=true --kubeconfig=/var/lib/kubelet/kubeconfig --cgroup-driver=cgroupfs',

 :proxy     => '--master=http://127.0.0.1:8080',
 :apiserver => '--insecure-bind-address=127.0.0.1 --etcd-servers=http://127.0.0.1:2379,http://127.0.0.1:4001 --service-cluster-ip-range=10.254.0.0/16 --admission-control=NamespaceLifecycle,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota'
}
