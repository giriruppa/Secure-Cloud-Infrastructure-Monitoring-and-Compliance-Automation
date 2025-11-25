# Secure-Cloud-Infrastructure-Monitoring-and-Compliance-Automation
A secure cloud automation project using Terraform, Puppet, and Nagios on Azure. Terraform deploys the infrastructure, Puppet enforces system configurations, and Nagios provides real-time monitoring and alerts, creating a fully automated, secure, and self-healing cloud environment.

---

## 🚀 **Project Overview**

This project demonstrates how Infrastructure as Code (IaC), configuration management, and real-time monitoring can be combined to create a secure, self-healing cloud infrastructure.

* **Terraform** provisions Azure VMs, networking, and security (IaC).
* **Puppet** enforces security configurations and system compliance automatically.
* **Nagios Core** monitors VM health, service uptime, and performance metrics.

The result is an end-to-end automated DevSecOps pipeline for cloud environments.

---

## 🎯 **Objectives**

* Automate Azure cloud resource deployment
* Enforce consistent and secure configurations
* Implement real-time monitoring and alerting
* Demonstrate automated remediation using Puppet
* Build a cost-effective solution using Azure for Students

---

## 🏗️ **Architecture**

<img width="962" height="641" alt="image" src="https://github.com/user-attachments/assets/5854fbfa-63fa-441a-9cb7-3ae31f2af29b" />

```
Local Machine (Terraform)
        |
        v
Azure Cloud ───────────────────────────────
|  Resource Group                          |
|  VNet + Subnet + NSG                     |
|                                          |
|  VM #1: Puppet Master + Nagios Server    |
|  VM #2: Puppet Agent                      |
--------------------------------------------
```

* Terraform → Deploys complete Azure setup
* Puppet Master → Controls configurations
* Puppet Agent → Applies security rules
* Nagios → Monitors agent VM (Ping, SSH, CPU, RAM, Disk, NRPE)

---

## ⚙️ **Technologies Used**

### **Cloud**

* Microsoft Azure
* Azure Resource Manager (ARM)
* Azure NSG
  
### **Automation**

* Terraform


### **Configuration Management**

* Puppet Master & Puppet Agent

### **Monitoring**

* Nagios Core
* NRPE Plugins

---

## 🔧 **Implementation Steps**

### **1️⃣ Terraform Deployment**

* Installed Terraform
* Configured Azure provider
* Created Resource Group, VNet, NSG
* Deployed two Ubuntu VMs
* Applied infrastructure using:

  ```bash
  terraform init
  terraform apply
  ```
<img width="1920" height="1080" alt="Screenshot (341)" src="https://github.com/user-attachments/assets/4de81360-884e-48c2-b763-46b0109a0cc2" />
<img width="1050" height="591" alt="image" src="https://github.com/user-attachments/assets/28ef2bba-6ba6-4de7-9dee-40ef53acee66" />

### **2️⃣ Puppet Configuration**

* Installed Puppet Master on VM1
* Installed Puppet Agent on VM2
* Signed certificates
* Created manifests for firewall, auto-updates, SSH security
* Demonstrated dynamic configuration using templates
  
Agent 
<img width="1920" height="1080" alt="Screenshot (348)" src="https://github.com/user-attachments/assets/2cc16b6c-ad23-4a25-948f-799b5418dfd5" />

Master
<img width="1920" height="1080" alt="Screenshot (347)" src="https://github.com/user-attachments/assets/028a9617-b185-4f99-81f8-694f35e67c47" />

### **3️⃣ Nagios Monitoring**

* Installed Nagios Core on VM1
* Installed NRPE plugins on agent node
* Configured host checks (Ping, SSH, CPU, memory, disk)
* Accessed Nagios Web UI for real-time monitoring
<img width="1920" height="1080" alt="Screenshot (352)" src="https://github.com/user-attachments/assets/42e2c0d5-802c-4e3d-9397-820e507bd756" />
<img width="1920" height="1080" alt="Screenshot (355)" src="https://github.com/user-attachments/assets/b9a48427-2ac3-40c1-a5d4-014c257702c8" />

---

## 🛡️ **Real-World Use Case Demonstrated**

### **“Detection and Mitigation of DoS Attack Using Nagios + Puppet”**

* Simulated DoS traffic to Puppet Agent
* Nagios detected high latency & CPU load → triggered alert
* Email notifications sent to admin
* Puppet auto-applied firewall rules to block attacker
* System recovered → Nagios returned to GREEN

A real DevSecOps response workflow.

In a real-world attack scenario, if an attacker floods the cloud VM with a DoS attack, Nagios detects abnormal CPU usage, ping failures, and service downtime. Nagios immediately sends an email alert to the admin. At the same time, Puppet enforces automated security measures like blocking the attacker IP, enabling firewall protections, and securing SSH. This creates a self-healing cloud environment capable of detecting, alerting, and mitigating cyberattacks automatically.

<img width="1297" height="785" alt="image" src="https://github.com/user-attachments/assets/c3648c29-f68a-4ba7-bf1e-c370a68e9c90" />

---


---

## 📝 **Future Enhancements**

* Auto-scaling using VM Scale Sets
* SIEM integration (ELK/Splunk/Sentinel)
* CI/CD pipeline with GitHub Actions
* Containerization (Docker + Kubernetes)
* Advanced Puppet orchestration modules

---

## 🙌 **Contributors**

**Ruppa Giridhar**

---

## 📧 **Contact**

If you want to collaborate or improve this project:
📩 **[ruppagiri116@gmail.com](mailto:ruppagiri116@gmail.com)**

---
<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/b4709336-d8d6-4420-b2b0-087df823895c" />


