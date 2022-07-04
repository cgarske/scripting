#! /bin/bash
#Get existing portainer caontainer
portainer_ps=$(sudo docker ps -aqf "name=portainer")
echo $portainer_ps

#Stop portainer container
sudo docker stop $portainer_ps

#Remove existing portainer caontainer
sudo docker rm $portainer_ps

#Get existing portainer image
portainer_image=$(docker images --format="{{.Repository}} {{.ID}}" | grep portainer | cut -d' ' -f2)
echo $portainer_image
#Remove portainer image
docker image rm --force $portainer_image

#Rebuild new portainer container
docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
