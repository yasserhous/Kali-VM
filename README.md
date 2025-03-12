## 📜 Words of Wisdom  
> *As you progress through this project, you will encounter challenges that I did not face. Do not fear those challenges—they are opportunities to learn and grow.*  

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
image 2<br/>
![image](https://github.com/user-attachments/assets/9de93a03-bc98-43ec-a518-74b53a31f501) <br/>

## Step 2: Install the Kali Linux Distribution  

### 2.1 Download Kali Linux  
Visit the [official Kali Linux website](https://www.kali.org/get-kali/#kali-virtual-machines) and download the **VirtualBox version**, as VirtualBox will be used as the virtualization platform for this lab. The download process may take a few minutes.  

### 2.2 Extract the Kali Linux Package  
Once the download is complete, extract the package to a preferred location. Take note of this location, as it will be required when importing the Kali Linux operating system into VirtualBox.  

### 2.3 Import Kali Linux into VirtualBox  
Follow the [Kali Linux VirtualBox import documentation](https://www.kali.org/docs/virtualization/import-premade-virtualbox/) to add the operating system to VirtualBox.  

If the **VirtualBox Manager interface differs from the one shown in the documentation**, the Kali Linux virtual machine can still be added by navigating to:  
**Machine → Add**, then selecting the extracted Kali Linux `.vbox` file.  

---

## Step 3: Configure the Host-Only Network  

### 3.1 Ensure the VM is Connected to the Correct Network Adapter  
By default, the newly imported **Kali Linux VM may not be assigned to the correct network adapter**. The objective is to configure it to use the **Host-Only Network**, which creates an isolated and secure environment.  

- This configuration allows the VM to communicate **only with the host machine and other virtual machines** but **not with the internet**, reducing the risk of unintended malware spreading.  
- To configure this setting:  
  1. Open **VirtualBox** and select the **Kali Linux VM**.  
  2. Navigate to **Settings → Network**.  
  3. Identify the enabled network adapter and set **"Attached to"** as **Host-Only Adapter**.  
  4. Click **OK** to save the changes.  
  5. Start the VM and attempt to access the internet—there should be **no internet connectivity**, confirming successful isolation.  

---

### 3.2 Verify VM-to-Host Communication  
To ensure the VM can communicate with the host machine, perform a **ping test** in both directions.  

#### 3.2.1 Identify the Host-Only Adapter’s IP Address  
- In **VirtualBox**, go to **Tools → Properties**, select the appropriate network adapter, and locate the **IP address displayed at the bottom** (See image below). <br/> 
image 3 <br/>
![image](https://github.com/user-attachments/assets/bd3380f5-d98a-46ea-a593-a8edeb233eca) <br/>
#### 3.2.2 Enable the DHCP Server  
- In the **same settings panel**, navigate to the **DHCP Server** tab.  
- Enable the **DHCP Server** to allow the VM to obtain an IP address automatically.  
- Once enabled, the **lower and upper IP bounds** for all VMs will be assigned dynamically.  

#### 3.2.3 Find the VM’s Assigned IP Address  
- Open a terminal within Kali Linux and execute:  
  ```bash
  ip a
### 3.3 Conduct a Ping Test  

To verify that the **host and VM can communicate**, perform a **ping test** in both directions.

#### 3.3.1 Ping the VM from the Host  
To check if the host can reach the VM:  

1. Obtain the **IP address assigned to the VM** (found in [Step 3.2.3](#323-find-the-vms-assigned-ip-address)).  
2. Run the following command on the **host machine**:  

   ```powershell
   ping <VM_IP>
- If the connection is successful, the terminal will display ping replies similar to the following:
  ```bash
  Pinging 192.168.56.101 with 32 bytes of data:
  Reply from 192.168.56.101: bytes=32 time<1ms TTL=128
  Reply from 192.168.56.101: bytes=32 time<1ms TTL=128
  Reply from 192.168.56.101: bytes=32 time<1ms TTL=128

#### 3.3.2 Ping the Host from the VM
To check if the VM can reach the host:  

1. Obtain the Host-Only Adapter IP Address (found in [Step 3.2.1](#321-find-the-vms-assigned-ip-address)).  
2. Run the following command inside the Kali Linux VM terminal:

   ```powershell
   ping <Host_IP>
- If the connection is successful, the terminal will display ping replies similar to the following:
  ```bash
   PING 192.168.56.1 (192.168.56.1) 56(84) bytes of data.
   64 bytes from 192.168.56.1: icmp_seq=1 ttl=64 time=0.543 ms
   64 bytes from 192.168.56.1: icmp_seq=2 ttl=64 time=0.389 ms


## Running the Fork Bomb
### 5) Create a new file on Linux and write the following code:

https://github.com/yasserhous/Kali-VM/blob/e39436b2335a17c2e605a32b0fd412f73441a6ea/forkbomb.sh#L1-L10

## Troubleshooting  

### **Ensuring VM ↔ Host Communication**  
If the **host and VM are unable to communicate**, follow these troubleshooting steps.

#### **Issue: "Network Unreachable" when attempting to ping the host from the VM**  
**Possible Causes & Solutions:**  
- **The VM is not assigned an IP address.**  
  -  **Solution:** Enable the **DHCP server** in VirtualBox or assign a **static IP manually**.  
- **The Host-Only Adapter is misconfigured.**  
  -  **Solution:** Verify that the VM is attached to the **correct Host-Only Adapter** under **VirtualBox → Settings → Network**.  
---

### **Changing Double-Click Behavior on Linux**  
If **double-clicking an executable script opens it in a text editor instead of running it**, adjust the execution settings.

#### **Issue: Script opens in Vim or a text editor instead of executing**  
**Possible Causes & Solutions:**  
- **The file lacks execution permissions.**  
  - **Solution:** Grant execution permissions using:  
    ```bash
    chmod +x script.sh
- **The script is not launching correctly from the file manager.**  
  - **Solution:** Change the "Open With" application to `dbus-launch`:  

---

## Lessons Learned  

### **Key Takeaways from This Project**  
This project provided valuable hands-on experience in:  
- **Configuring secure networking** for malware analysis in a virtualized environment.  
- **Building an isolated VirtualBox network** while troubleshooting connectivity issues.  
- **Executing and analyzing the impact of a Denial-of-Service (DoS) attack** using a fork bomb.  
- **Documenting technical procedures effectively** to improve reproducibility.  

#### **Future Best Practices:**  
- Maintaining a **detailed project log** significantly improves troubleshooting efficiency.  
- Using a **journal-style documentation approach** aids in debugging, backtracking, and tracking progress over time.  

---

## References and Resources  

The following resources were instrumental in setting up and troubleshooting the secure virtual environment:  

- [VirtualBox Networking Guide](https://medium.com/@LDS_Cyber/set-up-a-host-only-malware-testing-environment-in-esxi-ec3522a3f8a5#:~:text=Creating%20a%20host%2Donly%20or,the%20evaluation%20of%20malicious%20software.)  
- [Fork Bomb Attack Explanation](https://www.youtube.com/watch?v=RhtjGp7oMvE)  
- [Setting Up a Hacking Lab](https://www.youtube.com/watch?v=mvsiuLzpx2E)  
- [Real Malware Samples for Testing](https://bazaar.abuse.ch/browse/)  

---
