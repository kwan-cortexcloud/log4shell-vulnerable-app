NAMESPACE_NAME="log4shell-cc" && \
kubectl create namespace $NAMESPACE_NAME || true && \
kubectl create secret docker-registry regcred \
  --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --profile=${AWS_PROFILE}) \
  --namespace=$NAMESPACE_NAME || true && \
kubectl apply -f log4shell.yml --namespace=$NAMESPACE_NAME