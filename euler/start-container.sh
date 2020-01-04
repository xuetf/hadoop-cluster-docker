#!/bin/bash

# the default node number is 3
N=${1:-3}

image_name='dist_euler:hdfs'

# start hadoop master container
sudo docker rm -f hadoop-master
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 8887:8889 \
                --name hadoop-master \
                --hostname hadoop-master \
                -v /home/ec2-user/workspace/master:/workspace \
                ${image_name}


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                -v /home/ec2-user/workspace/slave$i:/workspace \
	                ${image_name}
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
