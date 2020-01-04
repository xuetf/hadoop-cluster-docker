#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t dist_euler:hdfs -f euler/Dockerfile .

echo ""