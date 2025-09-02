# Home Lab Kubernetes set-up

This is how I set up a kubernetes cluster in my home lab using VMs runnind on a supermicro server.
I intend to use this cluster for running applications on a "production" cluster. I also have a
minikube cluster which I use for small experiments.

# Setting up the Kubernetes VMs

I am using ubuntu multipass for the VMs that I will set up as a Kubernetes cluster. I asked chatGPT
and this is what I got:

Got it 👍 You want to set up Kubernetes nodes using Ubuntu Multipass VMs. Let’s make a small cluster (say 1 control-plane node + 2 workers) and ensure the VMs have enough resources to handle Kubernetes workloads.


⚙️ Step 1: Decide on resources per VM
For a lightweight Kubernetes cluster:
Control-plane (master): 2 CPUs, 2–4GB RAM, 10GB disk
Worker nodes: 2 CPUs, 2GB RAM, 10GB disk each
If you plan to run heavier workloads (like databases), bump workers to 4GB RAM.



⚙️ Step 2: Launch VMs with Multipass
Run these commands on your host (Ubuntu/macOS/Windows with Multipass installed):



# Control-plane (master) node
```
multipass launch 22.04 \
  --name k8s-master \
  --cpus 2 \
  --mem 4G \
  --disk 20G
``` 

# Worker nodes
```
multipass launch 22.04 \
  --name k8s-worker1 \
  --cpus 2 \
  --mem 2G \
  --disk 15G

multipass launch 22.04 \
  --name k8s-worker2 \
  --cpus 2 \
  --mem 2G \
  --disk 15G
```


⚙️ Step 3: Get IP addresses
multipass list
You’ll see something like:
Name            State    IPv4             Image
k8s-master      Running  10.217.251.101   Ubuntu 22.04 LTS
k8s-worker1     Running  10.217.251.102   Ubuntu 22.04 LTS
k8s-worker2     Running  10.217.251.103   Ubuntu 22.04 LTS



⚙️ Step 4: SSH into nodes
multipass shell k8s-master
Do the same for worker nodes as needed.



⚙️ Step 5: Install Kubernetes (inside master node)
Example using kubeadm:


# On all nodes (master + workers):
```
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
  https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
  https://apt.kubernetes.io/ kubernetes-xenial main" | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubelet kubeadm kubectl containerd
sudo apt-mark hold kubelet kubeadm kubectl
```

⚙️ Step 6: Initialize cluster (on master)
```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
Then configure kubectl:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
Install a pod network (example with Flannel):
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

⚙️ Step 7: Join worker nodes
kubeadm init will print a kubeadm join ... command. Run that inside each worker node.
✅ Now you’ll have a working Kubernetes cluster on Multipass VMs.

# Automating using Ansible

Perfect 👌 Let’s automate the Multipass VM creation + Kubernetes install + cluster join with Ansible.
We’ll break this down into:
Provision VMs with Multipass
Install Kubernetes dependencies
Initialize master node
Join worker nodes



🔹 Step 1: Define inventory (cluster hosts)
Create a file called inventory.ini:

```
[master]
k8s-master ansible_host=10.217.251.101 ansible_user=ubuntu

[workers]
k8s-worker1 ansible_host=10.217.251.102 ansible_user=ubuntu
k8s-worker2 ansible_host=10.217.251.103 ansible_user=ubuntu

[kubernetes:children]
master
workers
```

⚠️ Replace the IPs with what you get from multipass list.
We’ll use the default ubuntu user created by Multipass.



🔹 Step 2: Playbook to provision Multipass VMs
Save this as multipass-provision.yml (this runs on your host, not inside the VMs):

```
---
- name: Create Kubernetes VMs in Multipass
  hosts: localhost
  connection: local
  tasks:
    - name: Launch master node
      command: multipass launch 22.04 --name k8s-master --cpus 2 --mem 4G --disk 20G
      args:
        creates: /var/snap/multipass/common/data/multipassd/vault/instances/k8s-master

    - name: Launch worker1 node
      command: multipass launch 22.04 --name k8s-worker1 --cpus 2 --mem 2G --disk 15G
      args:
        creates: /var/snap/multipass/common/data/multipassd/vault/instances/k8s-worker1

    - name: Launch worker2 node
      command: multipass launch 22.04 --name k8s-worker2 --cpus 2 --mem 2G --disk 15G
      args:
        creates: /var/snap/multipass/common/data/multipassd/vault/instances/k8s-worker2
```

Run it:
ansible-playbook multipass-provision.yml



🔹 Step 3: Kubernetes installation playbook
Save this as k8s-cluster.yml:

```
---
- name: Install Kubernetes dependencies
  hosts: kubernetes
  become: yes
  tasks:
    - name: Install dependencies
      apt:
        name:
          - apt-transport-https
          - ca-certificates
          - curl
        state: present
        update_cache: yes

    - name: Add Kubernetes GPG key
      shell: |
        curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
      args:
        creates: /usr/share/keyrings/kubernetes-archive-keyring.gpg

    - name: Add Kubernetes apt repo
      copy:
        dest: /etc/apt/sources.list.d/kubernetes.list
        content: |
          deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main

    - name: Install kubeadm, kubelet, kubectl, containerd
      apt:
        name:
          - kubelet
          - kubeadm
          - kubectl
          - containerd
        state: present
        update_cache: yes

    - name: Hold kube packages
      apt:
        name:
          - kubelet
          - kubeadm
          - kubectl
        state: present
        mark_hold: yes

- name: Initialize Kubernetes master
  hosts: master
  become: yes
  tasks:
    - name: Initialize kubeadm
      command: kubeadm init --pod-network-cidr=10.244.0.0/16
      args:
        creates: /etc/kubernetes/admin.conf
      register: kubeadm_init

    - name: Create kube config for ubuntu user
      command: "{{ item }}"
      with_items:
        - mkdir -p /home/ubuntu/.kube
        - cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
        - chown ubuntu:ubuntu /home/ubuntu/.kube/config

    - name: Install Flannel CNI
      become_user: ubuntu
      shell: kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
      environment:
        KUBECONFIG: /home/ubuntu/.kube/config

    - name: Save join command
      shell: kubeadm token create --print-join-command
      register: join_cmd

    - name: Save join command to file
      local_action:
        module: copy
        content: "{{ join_cmd.stdout }}"
        dest: ./join_command.sh

- name: Join workers to cluster
  hosts: workers
  become: yes
  tasks:
    - name: Read join command
      slurp:
        src: "{{ playbook_dir }}/join_command.sh"
      register: join_script

    - name: Run join command
      command: "{{ (join_script.content | b64decode).strip() }}"
      args:
        creates: /etc/kubernetes/kubelet.conf
```



🔹 Step 4: Run the playbooks
First create the VMs:
ansible-playbook multipass-provision.yml
Then install Kubernetes:
ansible-playbook -i inventory.ini k8s-cluster.yml



✅ At the end, you’ll have:
k8s-master initialized with Flannel networking
Workers joined automatically
kubectl get nodes should show all nodes Ready

# Adding SSH injection

Perfect — let’s make it fully hands-off by injecting your SSH key into the Multipass VMs when they are created.
By default, Multipass launches VMs with a fresh ubuntu user and passwordless sudo, but Ansible prefers key-based SSH. We’ll configure it so your host’s SSH key is copied into the VMs automatically.
🔹 Step 1: Generate an SSH key (if you don’t have one yet)
On your host:
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
Press Enter for all prompts (default location ~/.ssh/id_rsa).
🔹 Step 2: Update provisioning playbook to inject SSH key
Edit multipass-provision.yml so it pushes your public key into each VM:
---
- name: Create Kubernetes VMs in Multipass
  hosts: localhost
  connection: local
  vars:
    ssh_pub_key: "{{ lookup('file', lookup('env','HOME') + '/.ssh/id_rsa.pub') }}"
  tasks:
    - name: Launch master node
      command: multipass launch 22.04 --name k8s-master --cpus 2 --mem 4G --disk 20G
      args:
        creates: /var/snap/multipass/common/data/multipassd/vault/instances/k8s-master

    - name: Launch worker1 node
      command: multipass launch 22.04 --name k8s-worker1 --cpus 2 --mem 2G --disk 15G
      args:
        creates: /var/snap/multipass/common/data/multipassd/vault/instances/k8s-worker1

    - name: Launch worker2 node
      command: multipass launch 22.04 --name k8s-worker2 --cpus 2 --mem 2G --disk 15G
      args:
        creates: /var/snap/multipass/common/data/multipassd/vault/instances/k8s-worker2

    - name: Get IPs of all nodes
      command: multipass list --format csv
      register: multipass_list

    - name: Add SSH key to master
      command: multipass exec k8s-master -- bash -c "echo '{{ ssh_pub_key }}' >> /home/ubuntu/.ssh/authorized_keys"

    - name: Add SSH key to worker1
      command: multipass exec k8s-worker1 -- bash -c "echo '{{ ssh_pub_key }}' >> /home/ubuntu/.ssh/authorized_keys"

    - name: Add SSH key to worker2
      command: multipass exec k8s-worker2 -- bash -c "echo '{{ ssh_pub_key }}' >> /home/ubuntu/.ssh/authorized_keys"
Now Ansible will be able to SSH without asking for a password.
🔹 Step 3: Update inventory.ini
You can simplify your inventory.ini because Ansible will use your SSH key:
[master]
k8s-master ansible_host=10.217.251.101 ansible_user=ubuntu

[workers]
k8s-worker1 ansible_host=10.217.251.102 ansible_user=ubuntu
k8s-worker2 ansible_host=10.217.251.103 ansible_user=ubuntu

[kubernetes:children]
master
workers
🔹 Step 4: Run playbooks
Create VMs + inject SSH key:
ansible-playbook multipass-provision.yml
Deploy Kubernetes:
ansible-playbook -i inventory.ini k8s-cluster.yml
✅ After this, you’ll be able to ssh ubuntu@k8s-master from your host with no password, and Ansible will configure the cluster automatically.




✅ Fix Options
Option 1: Disable host key checking (quickest)
Add this to your Ansible config (ansible.cfg):
[defaults]
host_key_checking = False
Or set it as an environment variable before running playbooks:
export ANSIBLE_HOST_KEY_CHECKING=False
This tells Ansible not to prompt when it sees a new host.
Option 2: Automatically accept new keys
You can configure Ansible’s SSH args so it auto-adds host keys instead of asking:
In ansible.cfg:
[ssh_connection]
ssh_args = -o StrictHostKeyChecking=accept-new
This way, new keys are trusted automatically, but if a host key ever changes (possible MITM warning), you’ll still get a warning.
Option 3: Manually trust the hosts (more secure)
Before running Ansible, just SSH into each Multipass VM once:
ssh ubuntu@10.233.18.240
ssh ubuntu@10.233.18.245
ssh ubuntu@10.233.18.226
Type yes when prompted. After that, their fingerprints are stored in ~/.ssh/known_hosts, and Ansible won’t ask again.


