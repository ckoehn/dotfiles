alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -v'
alias gbc='git checkout -b'
alias gbcr='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gbd='git branch -d'
alias gbdr='git push origin --delete'
alias gc='git commit'
alias gca='git commit --verbose --all'
alias gcam='git commit --all --message'
alias gcm='git commit --message'
alias gco='git checkout'
alias gcp='git cherry-pick -x'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%an]" --decorate --date=short'
alias gll='git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%an]" --decorate --date=short --name-status'
alias gls='git log --graph --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%an]" --decorate --date=short'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gr='git remote -v'
alias gs='git status -sb'
alias gsh='git show'
alias gt='git tag -l -n1 | sort -V'
alias gtc='git tag -a -s'

alias k='kubectl'
alias ka='kubectl apply -f'
alias kcc='kubectl config use-context'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kga='kubectl get pods,services,deployments,statefulsets'
alias kgaw='watch -n1 -t kubectl get pods,services,deployments,statefulsets'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kl='kubectl logs'
alias klf='kubectl logs -f --tail=10'
alias kpf='kubectl port-forward'
alias kx='kubectl exec -it'

alias ap='pwd; echo "Continue?"; read; ansible-playbook --vault-password-file=~/.vault_pass.txt --diff -i inventory'
alias klo='kubelogin --username christian.koehn --password $(pass ldap-new | head -1)'
alias klop='klo --prod'

alias backup-home='rsync -ah --progress --stats --delete --exclude /.cache --delete-excluded /home/ckoehn/ /run/media/ckoehn/Master/home/'
alias sync-backup='rsync -ah --progress --stats --delete /run/media/ckoehn/Master/ /run/media/ckoehn/Slave/'
