---------System Requirements
Minimum:
256 MB of RAM
1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

---------Recommended:
4 GB+ of RAM
50 GB+ of drive space

AWS cloud placement recommendations:
EC2 (t3.large) instance in default VPC
Security Group ports 8080(custom TCP) and 22 should be open for inbound traffic(0.0.0.0/0)
Create a new IAM role(ex. ‘jenkins’), attach Administrator policy to that role, add that IAM role to your Jenkins EC2
AMI: Amazon Linux 2023


---------Installation Process
After you have up and running your virtual machine connect to it via SSH.


ssh -i "jenkins.pem" ec2-user@ec2-184-72-118-79.compute-1.amazonaws.com


Execute the following commands one by one, and pay attention to the output of each:

sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo yum install jenkins java -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins

After you have ensured that the Jenkins service is running: Active: active (running), you can permanently enable this service:

sudo systemctl enable jenkins
Next, you can proceed to the initial setup of Jenkins through the UI interface, which will be available on port 8080:

Retrieve the password from the path specified in the message:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword



-----------integration with Git by SSH
SSH into the Server:
First, SSH into the server where Jenkins is installed using your normal SSH method. You'll usually do this as a regular user with SSH privileges.

ssh -i "jenkins.pem" jenkins@ec2-184-72-118-79.compute-1.amazonaws.com
Install git:

sudo yum install git -y
Switch to the Jenkins User:

Once logged in, you might need to switch to the Jenkins user. This can be done using the sudo command:

sudo su -s /bin/bash jenkins
This command switches you to the Jenkins user, assuming it has been set up without a login shell. The -s /bin/bash part is to start a bash shell for the Jenkins user.
Make sure in advance that you are successfully logged in as the Jenkins user:  whoami

If the output shows 'jenkins,' you can proceed.
Generate public/private rsa key pair for jenkins user:
ssh-keygen -f /var/lib/jenkins/.ssh/id_rsa

Register your public key:
Register the public part of the generated key in your GitHub/GitLab account in the Settings/SSH section:



cat /var/lib/jenkins/.ssh/id_rsa.pub
Copy the obtained output and register it in the settings following the instructions of your Git system where you are registered.

Test ssh connection.
Once you’ve added your public key to Github, test ssh connection:
1) Create new repo ‘test’
2) Copy SHH URL
3) On your Jenkins EC2, as jenkins user, run git clone git@url.you.copied (it should clone your 'test' repo)
make sure that the project is successfully cloned.



----------------Install additional components
Install terraform and ansible on Jenkins instance (this is needed for Jenkins project):

Install Terraform on Jenkins EC2 instance:



sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform --version
Install Ansible on Jenkins EC2 instance:



sudo amazon-linux-extras install epel
sudo yum install ansible
ansible --version
 


