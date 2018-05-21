#!/usr/bin/env bash

ecs-cli configure --cluster hello-ecs-cli --region ${REGION} \
  --default-launch-type EC2 --config-name hello-ecs-cli

ecs-cli configure profile --access-key ${AWS_ACCESS_KEY_ID} \
  --secret-key ${AWS_SECRET_ACCESS_KEY} --profile-name  hello-ecs-cli


ecs-cli up --keypair ${KEY_PAIR} \
  --security-group ${SECURITY_GROUP} --cluster hello-ecs-cli \
  --vpc ${VPC} --subnets ${SUBNET} \
  --capability-iam --size 2 --instance-type ${INSTANCE_TYPE}
# security group은 이름이 아닌 id로 넣어야한다! 이름을 넣으면 클러스터는 생기는데 인스턴스가 안생김...


# test compose container up
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  up --create-log-groups --cluster hello-ecs-cli

# test compose scale up
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  scale 2 --cluster hello-ecs-cli

# shutdown compose container
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  down --cluster hello-ecs-cli

# 서비스 생성
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  service create --cluster hello-ecs-cli \
  --deployment-max-percent 200 \
  --deployment-min-healthy-percent 50 \
  --target-group-arn ${TARGET_GROUP_ARN} \
  --health-check-grace-period 30 \
  --container-name hello-ecs-app \
  --container-port 9460 \
  --create-log-groups

# 서비스 초기화
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  service up \
  --cluster hello-ecs-cli

ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  service scale 2 \
  --cluster hello-ecs-cli

# 서비스 업데이트
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  service up \
  --cluster hello-ecs-cli --force-deployment

# 서비스 삭제
ecs-cli compose --file hello-compose.yml \
  --project-name hello-ecs-cli \
  service down \
  --cluster hello-ecs-cli \
  down --cluster hello-ecs-cli

# 클러스터 삭제
ecs-cli down --cluster hello-ecs-cli