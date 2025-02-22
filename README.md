


# Secure Kali VM
## OVERVIEW
I successfully built a secure and isolated Kali Linux VM inside VirtualBox to serve as a safe environment for penetration testing and malware analysis.
This project involved configuring network isolation, enforcing firewall rules, and enabling secure file transfers between the host and VM.
I faced multiple technical challenges and resolved them through troubleshooting, Linux networking, and firewall management.

## Step By Step Setup
### 1) Install VirtualBox
#### 1.1) visit https://www.virtualbox.org/ and click on Download , and then choose the right executable based on your operating system. This lab will be done on a windows environment.
#### 1.2) Run the installer. For the purpose of this lab, you can install using the default settings.
### 2) Install Kali Linux distribution
#### 2.1) visit https://www.kali.org/get-kali/#kali-virtual-machines and install the VirtualBox version, because that's the virtualization software that we will use in this lab.
#### 2.2) unzip the package at the location of your choice, but note that location as the kali linux operating systemp will be added to your VirtualBox
### 3) Ensure your Kali Linux download is the correct file by comparing the hash of your vdi file with the hash provided on the website
#### 3.2) open Powershell on your windows and write the following command: Get-FileHash "[path to your vdi file].vdi" -Algorithm SHA256. The terminal will output a long hash value. this value should be compared to the checksum value on your Kali linux --> see image below:
![image](https://github.com/user-attachments/assets/e387ffb6-f5cc-4220-8e3c-9fb6132bef03)
#### 3.3) Follow the Kali Linux documentation to add the operating system https://www.kali.org/docs/virtualization/import-premade-virtualbox/
### 4) Setup the host only network 
### 5)verify that your vm is setup properly.



Creating a safe hacking environment
You would want to make sure you create a safe environment to since we will be working with real vulnerabilities. This project can go smoother with some basic knowledge of virtual machines and kali-linux. I highly recommend watching Network Chuck content.

Update:
Right now I am running into issues with creating a host only network on virtual box
step 1:
Download & Install virtual box:
https://www.virtualbox.org/
step 2:
Download & Install Kali Linux

Alright I just want to write a bunch of stuff on the journey around installing my first secure VM. I decided to install host only since for now, I did not need to access the internet. I thought it will be a straight forward process by following a tutorial, but I faced a few challenges:
-VM UI not showing multiple adapters in the network section:
![image](https://github.com/user-attachments/assets/f5f915e0-7669-45df-81d6-44e39c880110)
-When trying to figure out how to add it, one solution was to go to file --> Host Network Manager. But when I went to file, here is what I found:
![image](https://github.com/user-attachments/assets/cdd55b35-0d7d-40e7-be5a-e7c3e0f0df56)
As you notice, no Host Network Manager

At that moment, I realized my issue might very well be the virtualbox installation. I removed virtual box completely, and reinstalled it, and then I was finally able to see the network options. I still could bot find the  file --> Host Network Manager, but I found the Tools --> Properties options which contained everything I needed

sources:
Network Chuck how to build a HACKING lab : https://www.youtube.com/watch?v=mvsiuLzpx2E 
