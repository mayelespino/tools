# A study in containers and container orchestration

## Questions I need to answer:
- what is Kubernetes
- how to set it up
- cluster orchestration
- what is a container
- How to build them
- How to deploy them
- Fundamentals of containers
- How to set up without  AKS or AWS console
- Document how I learned.   
- what are cgroups
- what is chroot ?

# Links

## Containers and virtualization
- What is a Container? : https://youtu.be/EnJ7qX9fkcU
- The Benefits of Containers: https://youtu.be/cCTLjAdIQho
- What Are Containers? : https://youtu.be/wuhxSLapDe0
- Virtualization Explained: https://youtu.be/FZR0rG3HKIk
### VM vs. Container:
- https://youtu.be/98ZNU1KqJfc
  - OCI: Open Container Initiative
- https://youtu.be/TvnZTi_gaNc
  - VMs are like houses, Containers are like appartments.
- Containers and VMs - A Practical Comparison: https://youtu.be/L1ie8negCjc
### Docker
- Docker: What do we mean?: https://youtu.be/IhUvORodQAQ
- Container Registry : 
  - https://youtu.be/76rX4s73MrM
  - https://youtu.be/jpC_p3bxXCI


## Kubernetes
- https://youtu.be/1xo-0gCVhTU
- Learn more about Kubernetes: http://ibm.biz/learn-kubernetes-guide 
- kubernetes Explained, overview: https://youtu.be/aSrqRSk43lY
  - deploy create, delete, describe and debug steps
- deployments: https://youtu.be/Sulw5ndbE88
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
- Excellent tutorial that puts containers, docker and kubernetes together: https://youtu.be/1xo-0gCVhTU
- Kubernetes Concepts Explained in 9 minutes!: https://youtu.be/QJ4fODH6DXI
- Kubernetes Architecture Simplified | K8s Explained in 10 Minutes: https://youtu.be/8C_SCDbUJTg
- Kubernetes - Services Explained in 15 Minutes!: https://youtu.be/5lzUpDtmWgM
- Kubernetes for Sysadmins: https://youtu.be/HlAXp0-M6SY
## Components
- Etcd: https://youtu.be/L9xkXzpEY6Q
- Istio:
- Kialy:
- Confd:
- Amdatu tools: scalerd deployer.
## Minikube
- [minikube readme](../minikube/readme.md)
 
## Deployments
- ubernetes in production - blue-green deployment, auto scaling and deployment automation: https://youtu.be/-Ci4vd4rh4M
  - You can use the API to  integrate in to your own tools, you could make your own kubectl.
  - Confd uses Etcd to update configuration dynamically
  - Intro to the Deployer (concept independent from K8s) Amdatu is an opensource deployer



## Container Orchestration 
  - https://www.youtube.com/watch?v=rmf04ylI2K0
  - https://youtu.be/kBF6Bvth0zw
  - Container orchestration: https://youtu.be/kBF6Bvth0zw
    - What orchestration does:
      - Deploy
      - Scaling
      - Network
      - Insight. mentions service mesh as a tool trace the requests through services. Examples like prometheos?,istio?
