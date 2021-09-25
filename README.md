# jenkins-learning
# We have two servers/systems/containers primarily :  jenkins container (on which jenkins is running )  and remote-host container ( container on which will perform activity)

1. Madotory software installation in amazon linux:
      sudo yum update -y && \
      sudo yum -y install docker && \
      sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \
      sudo chmod +x /usr/local/bin/docker-compose
      
      sudo useradd dockeruser && \
      sudo passwd dockeruser
      
      sudo useradd -aG docker dockeruser
      sudo useradd -aG wheel dockeruser  [not a mandatoy step]

2. Create the ssh key inside the folder location remote-host-iamge : ssh-keygen -f remote_key
3. Come to the parent location(where docker-compose file is located) and Build the image :  docker-compose build
4. [For setting up SSH Connection from jenkins to remote_host system]
   Copy the remote_key file to the location /var/lib/docker/volumes/jenkins-jenkins-data/_data/  
                                 or
   docker cp ./remote-host-image/remote_key myjenkins:/var/jenkins_home/

   Login to the jenkins container :  docker exec -u 0 -it myjenkins bash (using root)
   change owner permission : chown jenkins:jenkins /var/jenkins_home/remote_key

4. [For setting up the ansible in the jenkins container] : Here using ansible we are trying to perform activity in the remote_host system
   Copy the hosts file to the location /var/lib/docker/volumes/jenkins-jenkins-data/_data/
                               or
   docker cp ./jenkins-ansible/hosts  myjenkins:/var/jenkins_home/        [myjenkins ---> jenkins container name set in docker compose file]

   Cpoy the ansible.cfg file to the location /var/lib/docker/volumes/jenkins-jenkins-data/_data
                           or
   docker cp ./jenkins-ansible/ansible.cfg  myjenkins:/var/jenkins_home/

   Login to the jenkins container :  docker exec -it myjenkins bash (using jenkins user)  or   docker exec -u 0 -it myjenkins bash (using root)

   set the ANSIBLE_CONFIG env variable  :  export ANSIBLE_CONFIG = /var/jenkins_home/ansible.cfg
   set the host file location the ansible.cfg inventory position
   
   for testing run the below commands from the jenkins serever:
      1. go to jenkins home location :  cd $HOME or cd
      2. ansible test --list-hosts   ------>   these command should show list of valaible host (remote_host in oure case)
      3. ansible -m ping
