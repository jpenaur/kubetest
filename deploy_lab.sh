docker build -t registry.ng.bluemix.net/jpenaur/mytodos:v1 .
docker tag mytodos:v1 registry.ng.bluemix.net/jpenaur/mytodos:v1
docker push registry.ng.bluemix.net/jpenaur/mytodos:v1

bx cr images

kubectl delete --ignore-not-found=true -f deploy2kubernetes.yml

kubectl create -f deploy2kubernetes.yml