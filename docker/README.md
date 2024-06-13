# Docker files

 [my docker profile in dockerhub](https://hub.docker.com/u/mayelespino)

# Run container with bindmound to share the source code
'''
 docker run -d \
   -it \
   --name devtest \
   --mount type=bind,source="$(pwd)"/target,target=/app \
   nginx:latest

'''

Use '''docker inspect devtest'''  to verify that the bind mount was created correctly

To stop a container
'''
docker container stop devtest
docker container rm devtest
'''

Use a bind mount with compose
A single Docker Compose service with a bind mount looks like this:

'''
version: "3.9"
services:
  frontend:
    image: node:lts
    volumes:
        - type: bind
          source: ./static
          target: /opt/app/staticvolumes:
    myapp:
'''

[docker login](https://docs.docker.com/engine/reference/commandline/login/)

[docker exec](https://docs.docker.com/engine/reference/commandline/exec/)

To run a shell: ''' docker exec -it ubuntu_bash bash'''

[jenkins with docker compose](https://www.cloudbees.com/blog/how-to-install-and-run-jenkins-with-docker-compose)

# Links

- https://linuxconfig.org/how-to-customize-docker-images-with-dockerfiles
- https://unix.stackexchange.com/questions/336392/e-unable-to-locate-package-vim-on-debian-jessie-simplified-docker-container
- https://docs.docker.com/storage/
