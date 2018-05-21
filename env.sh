#!/bin/sh
export AWS_ACCESS_KEY_ID=`aws configure get default.aws_access_key_id`
export AWS_SECRET_ACCESS_KEY=`aws configure get default.aws_secret_access_key`
export SECURITY_GROUP="sg-eb78cc81"
export VPC="vpc-96b8a9ff"
export SUBNET="subnet-3bad4053"
export REGION="ap-northeast-2"
export INSTANCE_TYPE="t2.medium"
export KEY_PAIR="docker"
export TARGET_GROUP_ARN="arn:aws:elasticloadbalancing:ap-northeast-2:458834177603:targetgroup/hello-service/d234a8f93453568d"
export ECR_HOST="458834177603.dkr.ecr.ap-northeast-2.amazonaws.com"
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY