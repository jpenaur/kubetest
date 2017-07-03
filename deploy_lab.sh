#Checking if cluster or workers not ready
IP_ADDR=$(bx cs workers $CLUSTER_NAME | grep normal | awk '{ print $2 }')
if [ -z $IP_ADDR ]; then
  echo "$CLUSTER_NAME not created or workers not ready"
  exit 1
fi

echo -e "Configuring vars"
exp=$(bx cs cluster-config $CLUSTER_NAME | grep export)
if [ $? -ne 0 ]; then
  echo "Cluster $CLUSTER_NAME not created or not ready."
  exit 1
fi
eval "$exp"

docker run hello-world
docker build -t registry.ng.bluemix.net/jpenaur/mytodos:v2 .
docker tag mytodos:v1 registry.ng.bluemix.net/jpenaur/mytodos:v2
docker push registry.ng.bluemix.net/jpenaur/mytodos:v2

bx cr images

kubectl delete --ignore-not-found=true -f deploy2kubernetes.yml

kubectl create -f deploy2kubernetes.yml