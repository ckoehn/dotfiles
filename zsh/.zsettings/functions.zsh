tunnel-anything () {
	ssh -M -S /tmp/tunnel-anything -fnNT -L "9999:localhost:$1" "$2"
	vared -p "Tunnel to '$2', Port 9999->$1 (Press Enter to quit)" -c tmp
	ssh -S /tmp/tunnel-anything -O exit "$2"
}

kxi () {
	local pod=($(kubectl get pods | fzf | awk '{print $1}'))
	local cmd=${@:-"sh"}
	echo ${pod}
	kubectl exec -it ${pod} ${cmd}
}

klfi () {
	local pod=($(kubectl get pods | fzf | awk '{print $1}'))
	local attr=${@:-"--tail=10"}
	echo ${pod}
	kubectl logs -f ${attr} ${pod}
}

kdi () {
	local typ=${@:-"pods"}
	local item=($(kubectl get ${typ} | fzf | awk '{print $1}'))
	kubectl describe ${typ} ${item}
}
