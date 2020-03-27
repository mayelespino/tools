# Containers and container orchestration

# Questions and answers

## Q: What is a container?
### Fundamentals of containers
- At it's core it is a sandbox, running an isolated process. Typically one process per container. This is a runtime representation of a container. Cgroups and Process Namespace are used to create the sandbox.
- It is a container image. It is a binary representation of the process to run in the sandbox. A container 
- It is an ecosystem. The pieces that work together to make use of containers:
  - The host
  - The client and deamon, the software that operates on containers. Does things like:
    - Image push/pull
    - contaner run/stop
  - The definition file, which describes how to build the image.
- Containers are ephimeral When the container is destroyed the state is gone. To maintain state, disk space must be mounted to save state or write to a service(like a db).
- There are several impementations: Docker, rocket (rkt), lxc, RailCar and others.
### The components
- A container image: A container is packaged with all of it's dependencies. Nothing is installed in the container, the image binary runs on the container.
  - Images have layers organized in a heriarchy. Each layer is a snapshot. 
  - The can be an Image cache on the container host/manager which is shared across containers.
  - Images are permanent. When updating an image, by ssh in to the box or in a container definition file, only the delta is pushed/pulled to/from the image cache and the registry.
  - includes all of the dependecies above the kernal. 
- The Registry:
  - works like GIT, but for images. It can public or private, RBAC permissios can be managed there.
  - only the deltas are pushed pulled.
- The client and deamon:
  - the client talks interacts with the deamon, and other components.
  - the deamon starts/stops processes, sets up the network, retrieves logs and events. 
- The names spaces, determines "what you can see", for example:
  - NET namespace for managing network interfaces. ```ip netns add <new namespace name>```
- Cgroups are organized in a heriarchical tree, determines "what you can use":
  - Memory cgroup for managing accounting, limits and notifications.
  - CPU group for managing user / system CPU time and usage.
  - BlkIO cgroup for measuring & limiting amount of blckIO by group.
  - ``` /etc/cgconfig.conf ```
- Container host. , the actual machine were the container runs.

### How to install from scratch
- I've only used Docker. Here are the instructions on how to install docker: https://docs.docker.com/docker-for-mac/install/


## Container VS. VM
| | |
|--|--|
| Container | VM |
| Runs a prefabricated image. Dependecies, like libraries are baked in to the image, taking advantage of the image cache which makes dependency management much easier. |It can run a prefabricated image, but typically gets set up using configuration management, at least for the (first) image to be used as the template. The user needs to keep track and manage the dependencies.|
| Runs on top of the host's OS | Runs a copy of the OS on top of a hypervisor, on top of the host OS.|
| Shares CPU & Disk from Host OS | Has it's own CPU and Disk resources |
| Does not need its own copy of the guest OS | Each VM has its own guest OS image, about 2.1G |
| The image cache makes it easy to manage dependencies | Each time there is a change in a part of the image a whole new image must be built.|
| Does not maintain state out of the box, to write to a file system a file system you need to mount a volume from the host, or write to a service.  | Typically has a filesytem bult in, which is not shared. To preserve state, the state can be written to the local filesystem or a shared service, like a DB. |
| Almost as secure/isolated as VMs. | Much more isolated and secure. |
| Containers are like apartment buildings. | VMs are like houses. |

## Q: What is Kubernetes?
- Kubernetes is one of a few containter orchestration products. Others are Docker swarm and MesOs and openshift.
### Fundamentals of container orchestration
- Container: a sandbox running an image
- Cluster: consists of one master machine and multiple worker machines or nodes. The master coordinates between all the nodes.
- Pod: the smallest unit of a cluster. It represents a running process on a cluster.
- Master Node: A compute resource, typically a VM, which manages the worker nodes.
- Worker Node: A compute resource, typically a VM.
- Container orchestration makes these easier: 
    - Deployment
    - Management
    - Scaling
    - Development 
    - Monitoring
- Deployment
  - Desired state: The number of nodes needed to be running. What image version to run. 
  - Rolling deployments 
  - Rolling back a deployment
- Container Management:
  - Maintain desired state: if nodes die, a new one takes it's place.
  - Scheduling: The scheduler is used to achives the desired state. It creates or deletes pods.
- Scaling: The way to make the best use of the resources.
  - Scale up
  - Scale down
  - Can be done manually or automatically
  - Based on user load
- Service Discovery
  - Services: The way access the applications.
  - service registry/discovery: When new apps are broght up they are adverticed via service. When nodes are created they are added to the service.
  - KubeDNS makes it easy to have services find each other by name.
  - A service can be : LB, Node port, Cluster IP and others.
- Monitoring/Insight: To find out what is going on with the application.
  - Monitor performance and health of the containers.
### Components (Kubernetes)
#### On Master and Worker nodes
- Deamon (Kubelet)
- EtcD 
- Container runtime
#### On Master node
- Control Plane has the following:
  - Scheduler: Identifiest the right nodes to run the right containers to achive the desired state.
  - API Server 
  - Controler manger:
    - Node controler
    - Replication controler
- EtcD server/master
### On worker node
- Kubeproxy service


## Q: How to set it up from scratch?
- I've installed minikube. Here are the instructions:https://kubernetes.io/docs/tutorials/hello-minikube/
- I've not installed Kubernetes from scratch. Here are the instructions:
  - install nodes
  - install master
  - get nodes to join the cluster


|  |  |  |
|--|--|--|
| On Master & Slave | On Master (Machine) | On Slave (Machine) |
| Set up hostname | Initialilze cluster | Join Cluster |
| Set up static IP | Install POD network |  |
| Install Open SSH  | SetUp Dashboard (optional) |  |
| Install Docker |  |  |
| Install KubeAdmin |  |  |
| Install Kubelet |  |  |
| Install Kubectl |  |  |


# Links

## Containers and virtualization
- What is a Container? : https://youtu.be/EnJ7qX9fkcU
- The Benefits of Containers: https://youtu.be/cCTLjAdIQho
- What Are Containers? : https://youtu.be/wuhxSLapDe0
- Virtualization Explained: https://youtu.be/FZR0rG3HKIk
- Containers 101: https://youtu.be/VqLcWftIaQI
- Containerization Explained: https://youtu.be/0qotVMX-J5s
- Namespaces in linux: https://blog.scottlowe.org/2013/09/04/introducing-linux-network-namespaces/
- Cgroups: https://www.digitalocean.com/community/tutorials/how-to-limit-resources-using-cgroups-on-centos-6
- Building a container from scratch in Go: https://youtu.be/Utf-A4rODH8
  - Liz's git hub: https://github.com/lizrice/containers-from-scratch/blob/master/main.go
  - Containers from scratch: The sequel - Liz Rice: https://youtu.be/_TsSmSu57Zo

### VM vs. Container:
- Containers and how they differ from Virtual Machines: https://youtu.be/98ZNU1KqJfc
  - OCI: Open Container Initiative
- Virtual Machines vs Docker Containers - Dive Into Docker: https://youtu.be/TvnZTi_gaNc
  - Type 1 Hypervisor direct link to infrastructure, Type 2 Runs as an app on host OS.
  - VMs are like houses, Containers are like appartments.
- Containers and VMs - A Practical Comparison: https://youtu.be/L1ie8negCjc

### Docker
- Introduction To Docker and Docker Containers: https://youtu.be/JSLpG_spOBM  
- Docker: What do we mean?: https://youtu.be/IhUvORodQAQ
- Container Registry : 
  - https://youtu.be/76rX4s73MrM
  - https://youtu.be/jpC_p3bxXCI

## Container Orchestration 
- Container Orchestration Explained: https://youtu.be/kBF6Bvth0zw
  - https://www.youtube.com/watch?v=rmf04ylI2K0
  - https://youtu.be/kBF6Bvth0zw
- Container orchestration: https://youtu.be/kBF6Bvth0zw
  - What orchestration does:
    - Deploy
    - Scaling
    - Network
    - Insight. mentions service mesh as a tool trace the requests through services. Examples like prometheos?,istio?
- Container Orchestration Explained: https://youtu.be/kBF6Bvth0zw

## Kubernetes
- Kubernetes Explained: https://youtu.be/aSrqRSk43lY
- Introduction to Microservices, Docker, and Kubernetes: https://youtu.be/1xo-0gCVhTU
- Learn more about Kubernetes: http://ibm.biz/learn-kubernetes-guide 
- kubernetes Explained, overview: https://youtu.be/aSrqRSk43lY
  - deploy create, delete, describe and debug steps
- Deployments: https://youtu.be/Sulw5ndbE88
- kubernetes vs. docker: https://youtu.be/2vMEQ5zs1ko
  - kubernetes make these easier: 
    - Deployment
    - Scaling
    - Development 
    - Monitoring
- kubernetes vs openshift: https://youtu.be/cTPFwXsM2po
- One cluster or many?: https://youtu.be/a1ORgUtOeis
  -  high level architecture
  - pivotal Pks
- Understanding Kubernetes
  - Part 1: etcd clusters and key/value stores: https://youtu.be/CuWSY_fwV6M 
  - Part 2: The Scheduler https://youtu.be/E3ExWruji7g
  - Part 3: Master + API servers https://youtu.be/BrtvGHwyza0
- Tutorial that puts containers, docker and kubernetes together: https://youtu.be/1xo-0gCVhTU
- Kubernetes Concepts Explained in 9 minutes!: https://youtu.be/QJ4fODH6DXI
- Kubernetes Architecture Simplified | K8s Explained in 10 Minutes: https://youtu.be/8C_SCDbUJTg
- Kubernetes - Services Explained in 15 Minutes!: https://youtu.be/5lzUpDtmWgM
- Kubernetes for Sysadmins: https://youtu.be/HlAXp0-M6SY

### Installing from scratch
- Setup Kubernetes Cluster Step by Step | Edureka: https://youtu.be/UWg3ORRRF60
- Install Kubernetes On Ubuntu | Simplilearn: https://youtu.be/MyNnVurtSf0

### Kubernetes Architecture and Components
- Kubernetes Architecture Simplified | K8s Explained in 10 Minutes: https://youtu.be/8C_SCDbUJTg
- Kubernetes architecture explained: https://youtu.be/HJ6F05Pm5mQ
- Etcd: 
  - Kubernetes: ETCD for Beginners: https://youtu.be/L9xkXzpEY6Q
- Istio:
  - Welcome to Istio Training Course: https://youtu.be/9RK5AZgCT-Q
- Kialy:
- Confd:
- Amdatu tools: scalerd deployer.
- containers VS Node: https://medium.com/faun/understanding-nodes-pods-containers-and-clusters-778dbd56ade8

## Minikube
- [minikube readme](../minikube/readme.md)
 
## Deployments
- ubernetes in production - blue-green deployment, auto scaling and deployment automation: https://youtu.be/-Ci4vd4rh4M
  - You can use the API to  integrate in to your own tools, you could make your own kubectl.
  - Confd uses Etcd to update configuration dynamically
  - Intro to the Deployer (concept independent from K8s) Amdatu is an opensource deployer
