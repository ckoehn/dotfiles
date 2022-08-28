tunnel-anything () {
	ssh -M -S /tmp/tunnel-anything -fnNT -L "9999:localhost:$1" "$2"
	vared -p "Tunnel to '$2', Port 9999->$1 (Press Enter to quit)" -c tmp
	ssh -S /tmp/tunnel-anything -O exit "$2"
}

kxi () {
	local pod=$(kubectl get pods | fzf | awk '{print $1}')
	local containers=$(kubectl get pods "${pod}" -o jsonpath='{.spec.containers[*].name}')
	local container=${containers}
	if [[ $containers =~ ' ' ]]; then
		container=$(echo "${containers}" | tr ' ' '\n' | fzf)
	fi
	echo "${pod}" - "${container}"
	kubectl exec -it "${pod}" -c "${container}" -- "${@}"
}

kli () {
	local pod=$(kubectl get pods | fzf | awk '{print $1}')
	local containers=$(kubectl get pods "${pod}" -o jsonpath='{.spec.containers[*].name}')
	local container=${containers}
	if [[ $containers =~ ' ' ]]; then
		container=$(echo "${containers}" | tr ' ' '\n' | fzf)
	fi
	echo "${pod}" - "${container}"
	kubectl logs "${@}" "${pod}" -c "${container}"
}

klfi () {
	kli -f --tail=10
}

kdi () {
	local typ=${1:-"pods"}
	local item=$(kubectl get "${typ}" | fzf | awk '{print $1}')
	kubectl describe "${typ}" "${item}"
}

kcn () {
	if [ -z "$1" ]; then
		echo "Please specify a namespace."
		return 1
	fi
	local current=$(kubectl config current-context)
	kubectl config set-context "${current}" --namespace="${1}"
}

kcni () {
	local ns=$(kubectl get namespace | fzf | awk '{print $1}')
	local current=$(kubectl config current-context)
	kubectl config set-context "${current}" --namespace="${ns}"
}

kcci () {
	local context=$(kubectl config get-contexts --output='name' | fzf)
	kubectl config use-context "${context}"
}
