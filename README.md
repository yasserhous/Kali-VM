*DISCLOSURE* This repository is currently in progress. I use it to document my progress. 

Words of Wisdom
As you are progressing into this project, know that you will face challenges that I did not face. Do not fear those challenges, as they will help you learn.

# Secure Virtual Envrionment for Malware analysis
## OVERVIEW
I successfully built a secure and isolated Kali Linux VM inside VirtualBox to serve as a safe environment for penetration testing and malware analysis.
This project involved configuring an isolated network on a virtual machine using Kali linux and virtualbox, creating a forkbomb malware, and observing the impact.
I faced multiple technical challenges and resolved them through troubleshooting, and patience.

Ultimately, the final test would be to execute malware, investigate pcap files, all in a safe and isolated environment

It look me some time to finalize the host only network setup for my virtualbox because I ran into some configuration issues(see troubleshooting steps), but eventually I was able to set it up such as 1) my VM can communicate with my host and I can share a file(so I can share the malware zip), and 2) my VM cannot access the internet. 

Then I needed to find tutorials that demonstrate the execution of a malware on a virtual machine. I did not find many resources online, but I did find a website I can download real malware samples: https://bazaar.abuse.ch/browse/. For this first lab, I decided to go for a fork bomb A.K.A rabbit virus. Fork bombs are a type DOS attack(Denial of Service) Leverages Linux's concept called forking because each function call spawns two additional processes and it does that exponentially. A fork bomb crashes the system by exhausting the its resources. the operating system because overwhelmed with all the processes created by the program and can no longer respond.

To visualize it, we will write the function inside an executable, followed by some drama by having a pop up that says " Gotcha ! you're system will crash now " 

image 1
![forkbomb](https://github.com/user-attachments/assets/d53f5be5-563d-42fc-8301-d20f8435b0f3)

## Step By Step Setup
##  1) Installation of VirtualBox  

###  Step 1.1: Download VirtualBox  
Visit [VirtualBox's official website](https://www.virtualbox.org/) and navigate to the **"Download"** section.  
Select the appropriate executable based on the operating system.  

- Since this lab is conducted in a **Windows environment**, select **"Windows Hosts"**.  
- The download process may take a few minutes.  

###  Step 1.2: Install VirtualBox  
1. Run the installer and proceed with the **default settings**.  
2. **Do not remove the "VirtualBox Host-Only Networking" option** during installation.  
   - This setting is required to ensure the **virtual machine remains isolated from the internet**.  

###  Step 1.3: Verify Installation  
After installation is complete:  
A **Host-Only Network Adapter** should be visible in **Windows network settings**.  
This confirms the successful setup of VirtualBox's networking configuration.  

---
image 2
![image](https://github.com/user-attachments/assets/9de93a03-bc98-43ec-a518-74b53a31f501) <br/>
### 2) Install Kali Linux distribution
#### 2.1) visit https://www.kali.org/get-kali/#kali-virtual-machines and install the VirtualBox version, because that's the virtualization software that we will use in this lab. This download should take a few minutes as well.
#### 2.2) unzip the package at the location of your choice, but note that location as the kali linux operating system will be added to your VirtualBox
#### 3) Follow the Kali Linux documentation to add the operating system on virtualbox. https://www.kali.org/docs/virtualization/import-premade-virtualbox/. My virtualbox manager did not look exactly like the one displayed in the documentation, but I managed to find the add option by going to machine --> add. 
### 4) Setup the host only network 
#### 4.1) By default, your newly added Kali Linux OS might not be connected to the right network adapter. The goal is to connect it to the host-only network to create an isolated secure environment. Your VM will be able to communicate with the host or other VMs , but not to the outside world. Since the intention is to use this VM for malware analysis, we want to minimize the risk for unintended infections spreading on the network. To ensure the right network adapter is selected, go to settings --> Network --> choose the adapter that is enabled --> change the "attached to" field to "Host-only Adapter" and press Ok. Once you run your VM, you can verify it the adapter kicked in by trying to access the internet from the VM. you should not be able to do so.
#### 4.2) We need to ensure that our VM can communicate with our host, and we achieve this by pinging from host to VM, and from VM to host. the ip that the VM needs to use to reach the hos can be found on virtual box by going to Tools --> Properties and selecting the right adapter. The ip address should be displayed at the bottom (see image 3 below).
#### 4.3) At the same place, enable the DHCP server in order to have an ip automatically assigned to the VM. The option to enable can be found under the DHCP Server tab. Once it is enabled, you will find new ips assigned as lower bound and upper bound for all the VMs on Virtualbox
#### 4.4) to find it the ip assigned to the VM, open the terminal on Kali linux and run the command: ip a. the ip should show next to inet.
#### 4.5) Ping the VM from the host using the ip address found in 4.4. If it works the terminal will output replies. Also Ping the host from the VM using the ip address found in 4.2. If it works, the terminal will output replies.

image 3
![image](https://github.com/user-attachments/assets/bd3380f5-d98a-46ea-a593-a8edeb233eca) <br/>

## Running the Fork Bomb
### 1) Create a new file on Linux and write the following code:

https://github.com/yasserhous/Kali-VM/blob/e39436b2335a17c2e605a32b0fd412f73441a6ea/forkbomb.sh#L1-L10


## Troubleshooting

### When trying to find the file hash for the Kali vdi file, I was not able to CD into the directory
I searched and found that when a folder has a space in it on windows, it needs to put into quotation in a powershell terminal<br/>
![image](https://github.com/user-attachments/assets/a6452dcf-7e67-48f6-a9b2-e454fb8bf28f) <br/>


### Ensuring VM can reach Host, and host can reach VM
error: From 192.168.56.101 icmp_seq=3 Destination Host Unreachable <br/>
  1) check your network adapter and ensure that the one you want to use is enabled: Control Panel\All Control Panel Items\Network Connections <br/>
    ![image](https://github.com/user-attachments/assets/81c83f81-efc4-4355-ad9e-6ac3c8c76bc5) <br/><br/>
  2)ensure that the VM network adapter chosen is the right one: <br/><br/>
  ![image](https://github.com/user-attachments/assets/e5b4609a-113d-4e94-9b9a-7380da1121fe)  <br/><br/>
  3)run command ip a on your VM terminal and make sure your eth0 on the VM  shows <br/><br/>
  ![image](https://github.com/user-attachments/assets/9baf824d-05ff-4853-8dce-2277b52ec4ed) <br/><br/>
  4)go to tools --> Host-Only Networks and ensure that the IP assigned to your adapter is the same as the one to your host: <br/><br/>
  ![image](https://github.com/user-attachments/assets/941e3480-14ef-4d9e-bc00-f3af70801006) <br/><br/>

### Changing the double click behavior on Linux.
  1) It took me maybe a few hours to figure that one out since when I was double-clicking, the file was opening with vim. I ended up changing the default application used by going to open-with --> dbus-launch. This forced the OS to launch a new D-bus session which allows the execution of the script.




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
Host-only network: https://medium.com/@LDS_Cyber/set-up-a-host-only-malware-testing-environment-in-esxi-ec3522a3f8a5#:~:text=Creating%20a%20host%2Donly%20or,the%20evaluation%20of%20malicious%20software.

