#!/bin/bash

#set -x

source /scripts/constants
source /etc/environment
source /scripts/utils.sh
exdir=$(executing_dir)

container=nas
container_image=searchathing/nas
#container_data=/nas/data/xxx

net=host
#net=nas

ip=
#ip=$ip_nas_srv

#privileged=
#privileged="--cap-add=SYS_ADMIN --cap-add=SYS_TIME --cap-add=SYSLOG"
privileged="--privileged"

cpus="4"
memory="4g"

dk-rm-if-exists $container

args_ip=""
if [ "$ip" != "" ]; then args_ip="--ip=$ip"; fi

docker run \
	-d \
	-ti \
	-e TZ=`cat /etc/timezone` \
	--name "$container" \
        --network="$net" \
	$privileged \
	$args_ip \
        --restart="unless-stopped" \
        --cpus="$cpus" \
        --memory="$memory" \
	--hostname=nas.my.local \
	--volume="/etc/letsencrypt:/etc/letsencrypt:ro" \
	--volume="/security/dc01/itadmin:/security/dc01/itadmin:ro" \
	--volume="/security/nas:/security/nas" \
	--volume="$exdir:/dk" \
	--volume="/nas:/nas" \
	--volume="/backup:/backup" \
        "$container_image"

docker logs -f "$container"
