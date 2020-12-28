# PlanMe

Cross Platform Application that help user to manage their time table in daily life

## Figma
https://www.figma.com/file/y5MPYCJQrs3Elh1QGetv4m/Planme


## Installation

### Install Git 
```
sudo apt update
sudo apt install git
```

### Install Docker
```
sudo apt-update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```
```
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```
```
sudo apt-key fingerprint 0EBFCD88
```
```
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
```
```
sudo apt-update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
### Install Docker Compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
```
sudo chmod +x /usr/local/bin/docker-compose
```
## Deployment
```
git clone https://github.com/ggolfz/planme.git
```
```
cd planme/server
docker-compose up
```