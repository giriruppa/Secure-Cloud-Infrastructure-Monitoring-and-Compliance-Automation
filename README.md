# Secure-Cloud-Infrastructure-Monitoring-and-Compliance-Automation
A secure cloud automation project using Terraform, Puppet, and Nagios on Azure. Terraform deploys the infrastructure, Puppet enforces system configurations, and Nagios provides real-time monitoring and alerts, creating a fully automated, secure, and self-healing cloud environment.

# **Secure Cloud Infrastructure Automation, Monitoring & Compliance**

A complete DevSecOps project integrating **Terraform**, **Puppet**, and **Nagios** on **Microsoft Azure** to build a secure, automated, and continuously monitored cloud environment.

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

```

<img width="962" height="641" alt="image" src="https://github.com/user-attachments/assets/5854fbfa-63fa-441a-9cb7-3ae31f2af29b" />

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
  
<img width="1050" height="591" alt="image" src="https://github.com/user-attachments/assets/28ef2bba-6ba6-4de7-9dee-40ef53acee66" />

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

### **2️⃣ Puppet Configuration**

* Installed Puppet Master on VM1
* Installed Puppet Agent on VM2
* Signed certificates
* Created manifests for firewall, auto-updates, SSH security
* Demonstrated dynamic configuration using templates

### **3️⃣ Nagios Monitoring**

* Installed Nagios Core on VM1
* Installed NRPE plugins on agent node
* Configured host checks (Ping, SSH, CPU, memory, disk)
* Accessed Nagios Web UI for real-time monitoring

---

## 🛡️ **Real-World Use Case Demonstrated**

### **“Detection and Mitigation of DoS Attack Using Nagios + Puppet”**

* Simulated DoS traffic to Puppet Agent
* Nagios detected high latency & CPU load → triggered alert
* Email notifications sent to admin
* Puppet auto-applied firewall rules to block attacker
* System recovered → Nagios returned to GREEN

A real DevSecOps response workflow.

---

## 📸 **Screenshots (Attach as Needed)**

* Terraform Apply Output
* Azure Portal Resources
* Puppet Certificate Signing
* Nagios Dashboard
* NRPE Service Checks
* Architecture Diagram
* Email Alert Example

---

## 📂 **Project Folder Structure**

```
/terraform-project
/puppet
   └─ manifests
   └─ templates
/nagios
readme.md
```

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
B.Tech CSE
Lovely Professional University

---

## 📧 **Contact**

If you want to collaborate or improve this project:
📩 **[ruppagiri116@gmail.com](mailto:ruppagiri116@gmail.com)**

---

If you'd like, I can also generate:
✔ A **LICENSE** file
✔ A **project logo**
✔ A **short description badge section**
✔ A **final PDF report**

Just tell me!
