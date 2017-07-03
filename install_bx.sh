#!/bin/bash

echo "Download Bluemix CLI"
wget --quiet --output-document=/tmp/Bluemix_CLI_amd64.tar.gz  http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/latest/Bluemix_CLI_amd64.tar.gz
tar -xf /tmp/Bluemix_CLI_amd64.tar.gz --directory=/tmp

# Create bx alias
echo "#!/bin/sh" >/tmp/Bluemix_CLI/bin/bx
echo "/tmp/Bluemix_CLI/bin/bluemix \"\$@\" " >>/tmp/Bluemix_CLI/bin/bx
chmod +x /tmp/Bluemix_CLI/bin/*

export PATH="/tmp/Bluemix_CLI/bin:$PATH"


wget --quiet --output-document=/tmp/docker-1.13.1.tgz https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz
tar -xf /tmp/docker-1.13.1.tgz --directory=/tmp
ls /tmp
ls /tmp/docker
# Create docker alias
echo "#!/bin/sh" >/tmp/docker/docker
echo "/tmp/docker/ \"\$@\" " >>/tmp/docker/docker
chmod +x /tmp/docker/*



export PATH="/tmp/docker:$PATH"
docker run hello-world

# Install Armada CS plugin
echo "Install the Bluemix container-service plugin"
bx plugin install container-service -r Bluemix
bx plugin install container-registry -r Bluemix



echo "Install kubectl"
wget --quiet --output-document=/tmp/Bluemix_CLI/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x /tmp/Bluemix_CLI/bin/kubectl


if [ -n "$DEBUG" ]; then
  bx --version
  bx plugin list
fi