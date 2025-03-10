title: "Secure Virtual Environment for Malware Analysis"

overview: |
  This repository documents the development of a secure and isolated Kali Linux virtual machine within VirtualBox, designed as a controlled environment for malware analysis.

  The project involved:
    - Configuring an isolated network within VirtualBox
    - Creating and executing a fork bomb malware to observe system impact
    - Troubleshooting networking issues to ensure controlled communication between the VM and host
    - Establishing a secure environment for analyzing malicious files

  This environment was built to safely execute malware, analyze packet captures (PCAP files), and study system behavior, all within a controlled and isolated virtualized setup.

key_features:
  - Host-Only Networking Setup: Ensures VM isolation while maintaining communication with the host machine
  - Fork Bomb Execution and Analysis: Simulates Denial of Service (DoS) attacks by overwhelming system resources
  - Malware Handling in a Secure Lab: Prepares the system for safe execution of real-world malware samples
  - Hands-on Troubleshooting: Includes detailed fixes for common VirtualBox networking issues

project_setup:
  step_1_install_virtualbox:
    download: "Download VirtualBox from the [official website](https://www.virtualbox.org/)."
    install: |
      Install VirtualBox with default settings.
      - Do not remove the "VirtualBox Host-Only Networking" option, as it is required for network isolation.
    verify_installation: |
      Open Windows Network Settings and confirm that the Host-Only Network Adapter is present.
    example_image: "![VirtualBox Network Adapter](https://github.com/user-attachments/assets/9de93a03-bc98-43ec-a518-74b53a31f501)"

  step_2_install_kali_linux:
    download: "Download the Kali Linux VirtualBox image from the [official site](https://www.kali.org/get-kali/#kali-virtual-machines)."
    extract: "Extract the package to a selected directory."
    import: |
      Import the Kali Linux image into VirtualBox:
      - Navigate to Machine → Add within VirtualBox.
      - Follow the [Kali Linux VirtualBox import guide](https://www.kali.org/docs/virtualization/import-premade-virtualbox/).

  step_3_configure_host_only_networking:
    objective: |
      By default, Kali Linux may not be connected to the correct network adapter. 
      The goal is to connect it to the Host-Only Network, ensuring:
      - VM to Host communication
      - No external internet access

    configure_virtualbox_adapter: |
      1. Open VirtualBox → Select the Kali VM → Settings → Network
      2. Choose the enabled adapter → Set "Attached to" Host-Only Adapter
      3. Click OK and start the VM.
      4. Verify Isolation by attempting to access the internet from the VM (should be blocked).

    enable_dhcp: |
      1. Navigate to Tools → Properties → Select the Host-Only Adapter
      2. Enable the DHCP Server
      3. The DHCP settings should now display assigned IP ranges for VirtualBox VMs.

    example_image: "![Host-Only Adapter](https://github.com/user-attachments/assets/bd3380f5-d98a-46ea-a593-a8edeb233eca)"

    verify_connectivity:
      find_vm_ip: |
        Run the following command inside the VM:
        ```bash
        ip a
        ```
      ping_vm_from_host: |
        Run the following command on the host:
        ```powershell
        ping <VM_IP>
        ```
      ping_host_from_vm: |
        Run the following command inside the VM:
        ```bash
        ping <Host_IP>
        ```
      success_criteria: "If both pings succeed, the configuration is correct."

running_fork_bomb_attack:
  description: |
    The fork bomb (also called a Rabbit Virus) is a Denial of Service (DoS) attack that exploits Linux process forking. 
    The function continuously spawns new processes, overloading system resources and leading to a system crash.

  fork_bomb_script: "[Fork Bomb Script](https://github.com/yasserhous/Kali-VM/blob/e39436b2335a17c2e605a32b0fd412f73441a6ea/forkbomb.sh#L1-L10)"

  pop_up_warning: |
    To enhance the experience, a pop-up warning message was added before execution:
    ```bash
    zenity --error --text="System Failure Detected! Your system is about to crash!" --title="Security Warning" &
    sleep 3
    :(){ :|:& };:
    ```
    This simulates a real-world cyber attack scenario.

  example_image: "![Fork Bomb](https://github.com/user-attachments/assets/d53f5be5-563d-42fc-8301-d20f8435b0f3)"

troubleshooting:
  vm_host_communication:
    issue: "Network Unreachable when attempting to ping the host from the VM."
    fix: "Enable DHCP or manually assign an IP to the VM."

  linux_executable_behavior:
    issue: "Executable scripts open in `vim` instead of running."
    fix: "Modify Open With settings to use `dbus-launch`, ensuring execution."

lessons_learned:
  - Configuring secure networking for malware analysis
  - Building an isolated VirtualBox environment
  - Troubleshooting networking and execution issues in Linux
  - Documenting steps effectively for reproducibility

  key_takeaway: "Maintaining a detailed project log significantly improves troubleshooting efficiency and helps track progress over time."

references_and_resources:
  - "[VirtualBox Networking Guide](https://medium.com/@LDS_Cyber/set-up-a-host-only-malware-testing-environment-in-esxi-ec3522a3f8a5#:~:text=Creating%20a%20host%2Donly%20or,the%20evaluation%20of%20malicious%20software.)"
  - "[Fork Bomb Attack Explanation](https://www.youtube.com/watch?v=RhtjGp7oMvE)"
  - "[Setting Up a Hacking Lab](https://www.youtube.com/watch?v=mvsiuLzpx2E)"
  - "[Real Malware Samples for Testing](https://bazaar.abuse.ch/browse/)"

next_steps:
  - Expanding malware analysis beyond the fork bomb attack
  - Investigating packet captures (PCAPs) from executed malware
  - Implementing security monitoring tools within the VM

about_repository:
  status: "This repository is currently a work in progress. It serves as a technical portfolio project documenting the development of a secure malware analysis lab."
  contribution: "Contributions, suggestions, and feedback are welcome."
