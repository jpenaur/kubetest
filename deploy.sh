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


bx cr images

#Place deployment in directory

#Find the line that has the comment about the load balancer and add the nodeport def after this
let NU=$(awk '/^  # type: LoadBalancer/{ print NR; exit }' deploy2kubernetes.yml)+3
NU=$NU\i
sed -i "$NU\ \ type: NodePort" deploy2kubernetes.yml #For OSX: brew install gnu-sed; replace sed references with gsed

echo -e "Deleting previous version of app if it exists"
kubectl delete --ignore-not-found=true   -f deploy2kubernetes.yml

echo -e "Creating pods"
kubectl create -f deploy2kubernetes.yml

PORT=$(kubectl get services | grep frontend | sed 's/.*:\([0-9]*\).*/\1/g')

echo ""
echo "View the app at http://$IP_ADDR:$PORT"