### Dieses Repo erzeugt einen Kubernetes Cluster (nicht HA) mit kubeadm und ansible. 
#### Zusätzlich kann eine Kubernetes Demo mit einem Nignx Webserver verwendet werden um den Zustand des Clusters zu verifizieren. 



### Requirements: 
- Master-Node (ubuntu 22.04)
- mindestens 2 Worker-Nodes (ubuntu 22.04)
- einen host auf dem Ansible installiert ist


### Für die Nodes:
- 2 GB Ram oder mehr pro Host
- mindestens 2 CPUs pro Host 
- eine Netzwerkverbindung zwischen allen Hosts

### Ansible Host: 

 Der Ansible Host benötigt eine SSH Verbindung in die Master- und die Worker-Nodes
 Es kann je nach Präferenz ein RSA oder ein ed25519 Key erstellt werden. Beides funktioniert.
 
 ssh-keygen -t ed25519 (or rsa)
 ssh-copy-id -i /path/to/ed25519.pub ubuntu@IP-each-node



### 1. Die default Werte werden in einer ansible.cfg im Repo hinzufügen 
 
 Die ansible.cfg aus dem Repo kann verwendet werden. Alternativ kann auch durch das folgende Kommando ein neues File erstellt werden. In beiden Fällen sollte die Kommandos zum testen benutzt werden.

 Neues File:
 ansible-config init -t all --disabled > ansible.cfg

 Die folgenden Werte sollten in der ansible.cfg stehen. 
 
 [defaults]
 remote_user=ubuntu

 [privilege_escalation]
 become=True
 become_method=sudo
 

 Test der ansible.cfg:
 
 ansible --version
 ansible-config view

 bei der ansible.cfg ist zu beachten, dass der User Ubuntu durch die Variable für alle Playbooks festgelegt ist. Wenn ein andere Nutzer benötigt wird, muss dies in der ansible.cfg und in den Playbooks definiert werden. Das gleiche gilt für die Sudo-Rechte. 

### 2. Die verbindung zu allen Remote-Servern checken 

 ansible -i inventory.yaml all -m ping

### 3. Den cluster aufsetzen 
 ansible-playbook -K -i inventory.yaml kubeadm-playbooks/1-setup-user.yaml
 ansible-playbook -i inventory.yaml kubeadm-playbooks/2-setup-kube-dependencies.yaml
 ansible-playbook -i inventory.yaml kubeadm-playbooks/3-setup-master.yaml 
 ansible-playbook -i inventory.yaml kubeadm-playbooks/4-join-worker.yaml

### 4. Die Kubernetes-Demo starten 
 ansible-playbook -i inventory.yaml kubernetes-demo/demo-playbook.yaml

### 5. Der Zustand des Cluster kann mit den folgenden Kommandos verifiziert werden 
 
 -> ssh Verbindung in die master node

 kubectl get all --all-namespaces
 kubectl describe nodes
 kubectl get pods -o wide
 kubectl get svc
 curl localhost:32000 nginx-service/NodePort
