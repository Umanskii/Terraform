Instructions

1.brew install ansible 

2.sudo mkdir /etc/ansible 

3.sudo chown -R your_username:staff /etc/ansible

4. download ansible config file from repo ansible.cfg

5. put ansible.cfg into /etc/ansible

6. mkdir -p ~/tntk_projects/ansible

7. create the following directories under ~/tntk_projects/ansible

 mkdir -p ~/tntk_projects/ansible/roles ~/tntk_projects/ansible/playbooks ~/tntk_projects/ansible/inventory

8. download hosts file from repo 

9. put the host file below under ~/tntk_projects/ansible/inventory 

10 . setup passwordless ssh between your local machine and your EC2 instances. Refer to this doc SSH key-pair setup  

SSH key-pair setup

1. On your laptop run cat ~/.ssh/id_rsa.pub if the file doesn’t exist, generate a new key pair with ssh-keygen and run cat again

2. Copy the content of cat ~/.ssh/id_rsa.pub

3. SSH to each of your EC2 machines and append the output of cat ~/.ssh/id_rsa.pub that you copied in step 2 to /home/ec2-user/.ssh/authorized_keys and save

4. Exit from EC2 and test SSH connection without providing the .pem key
   
6. Now on your EC2 instance open ~/.ssh/authorized_keys

7. as you can see, it has the public key of your .pem file, now you need to add the output of ~/.ssh/id_rsa.pub in it and save it

