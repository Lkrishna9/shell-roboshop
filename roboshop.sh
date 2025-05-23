#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-009826b9b5d621eb1"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalouge" "user" "cart" "shipping" "payment" "dispatch" "fronend")
ZONE_ID="Z07370541QXT18547F7RY"
DOMAIN_NAME="devpracticers.site"
for instance in ${INSTANCES[@]}
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-009826b9b5d621eb1 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address: $IP"
    done