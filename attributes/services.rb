
default['kubernetes']['args'] = {
 :kubelet => '--logtostderr=true -v=2 --allow-privileged=true --api-servers=http://127.0.0.1 --kubeconfig=/var/lib/kubelet/kubeconfigi --cgroup-driver=cgroupfs',

 :proxy   => '--logtostderr=true -v=2 --master=http://127.0.0.1:8080 --kubeconfig=/var/lib/kube-proxy/kubeconfig'
}
