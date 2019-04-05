#!/bin/bash

# Usage
. tevarsMaker.sh {terraformScript/} {eu-east-2}

# Parameter 없으면
if [ ${#1} -eq 0 ];then 
    terraformPath="terraformScript"
else
    terraformPath=$1
fi     

if [ ${#2} -eq 0 ];then 
    zone="ap-northeast-2"
else
    zone=$2
fi
for i in $(cat keys.csv); do
    AK=$(echo $i|awk 'BEGIN{FS=","}{printf $1}')
    SK=$(echo $i|awk 'BEGIN{FS=","}{printf $2}')
    echo 'AWS_ACCESS_KEY="$AK"
AWS_SECRET_KEY="$SK"
AWS_REGION="$zone"    
'> $terraformPath/terraform.tfvars
    nowPath=$(pwd)
    cd $terraformPath
    terraform init
    terraform apply -auto-approve
    cd $nowPath
done
