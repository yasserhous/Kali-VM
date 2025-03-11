*DISCLOSURE* This repository is currently in progress. I use it to document my progress. 

Words of Wisdom
As you are progressing into this project, know that you will face challenges that I did not face. Do not fear those challenges, as they will help you learn.

# Secure Virtual Envrionment for Malware analysis
## OVERVIEW
I successfully built a secure and isolated Kali Linux virtual machine inside VirtualBox to serve as a safe environment for malware analysis.
This project involved configuring an isolated network on a virtual machine using Kali linux and virtualbox, creating a forkbomb malware, and observing the impact.
I faced multiple technical challenges and resolved them through troubleshooting, and patience.

Ultimately, the final test would be to execute malware, investigate pcap files, all in a safe and isolated environment

It took me some time to finalize the host only network setup for my virtualbox because I ran into some configuration issues(see troubleshooting steps), but eventually I was able to set it up such that my virtual machine can communicate with the host, while being isolated from the network. Then I was able to write a forkbomb and run it to study the impact of a Denial Of Service(DOS) attack.

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
### 5) Create a new file on Linux and write the following code:

https://github.com/yasserhous/Kali-VM/blob/e39436b2335a17c2e605a32b0fd412f73441a6ea/forkbomb.sh#L1-L10


## Troubleshooting


### Ensuring VM can reach Host, and host can reach VM
When running the ping from the virtual machine , I received a " network not reachable " message from the terminal. That was because I had to either a) assign an ip to VM manually, or enable DHCP server to do it automatically. I enabled the DHCP server .

### Changing the double click behavior on Linux.
  1) When attempting to run the executable created in step 5, It took me maybe a few hours to get it to work because when I was clicking it, it would open with VIM, and not execute the code. I ended up changing the default application used by going to open-with --> dbus-launch. This forced the OS to launch a new D-bus session which allows the execution of the script.

## Lessons Learned

I wish I can capture all the troubleshooting that happened during this project to clearly paint the picture of the learning journey of a SOC analyst. I had to do the installation steps 2 times to clearly capture the right steps. As a lesson, Documenting steps along the way in a journal-style approach will be something I will do more often as it helps with debugging, backtracking, and remembering the things to avoid.


sources:
Network Chuck how to build a HACKING lab : https://www.youtube.com/watch?v=mvsiuLzpx2E 
Fork Bomb: https://www.youtube.com/watch?v=RhtjGp7oMvE
Host-only network: https://medium.com/@LDS_Cyber/set-up-a-host-only-malware-testing-environment-in-esxi-ec3522a3f8a5#:~:text=Creating%20a%20host%2Donly%20or,the%20evaluation%20of%20malicious%20software.
