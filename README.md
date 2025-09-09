# Terraform_infrastructure
Creation of infrastructure in terraform (Vnet,subnet,load balancer, VMS,)

- **Virtual Network (VNet)**:  
  - CIDR: `10.0.0.0/16`  
  - Subnets:
    - `webapp-subnet` → 10.1.0.0/24 (hosts VM1 & VM2 for the web app)  Provisioning would be done elsewhere 
    - `database-subnet` → 10.2.0.0/24 (hosts VM3 for the database)  Provisioning would be done elsewhere

- **Network Interfaces (NICs)**:  
  - Static private IPs assigned to each VM:
    - VM1 → 10.1.0.5  
    - VM2 → 10.1.0.6  
    - VM3 → 10.2.0.5  

- **Virtual Machines**:  
  - 3 Linux VMs (Ubuntu 20.04 LTS Gen2) > Size can be changed 
  - SSH authentication using a public key (`~/.ssh/id_rsa.pub`)  > can be mapped to where you store your public key 

- **Public IP + Load Balancer**:  
  - Standard SKU Public IP  
  - Standard SKU Load Balancer  
  - Backend pool with VM1 & VM2  
  - Health probe on TCP port 22 (SSH)  
  - Load balancer rule mapping frontend port 22 → backend port 22
 

## 🛠️ What I Would Do in a Real Project

If this were a production deployment, I would make the following changes:

1. **No SSH Load Balancer**  
   - The load balancer would distribute **HTTP(S)** traffic (port 80/443) across the web app VMs.  
   - SSH would be restricted and managed via Bastion or jump hosts.

2. **Firewall as Entry Point**  
   - Deploy an **Azure Firewall** (or a third-party NVA) in the **hub VNet**.  
   - All inbound and outbound traffic would be inspected and filtered through the firewall.  
   - This enforces centralized security and logging.

3. **Separate VNets for Tiers**  
   - Instead of just separate subnets, I would isolate the tiers into **separate VNets**:  
     - **WebApp VNet** → contains VM1 & VM2  
     - **Database VNet** → contains VM3  
   - Use **VNet peering** to connect them.  
   - This provides an extra layer of security and better alignment with hub-and-spoke networking patterns.

4. **Network Security Groups (NSGs)**  
   - Apply NSGs to subnets and NICs for least-privilege rules.  
   - E.g., only allow web traffic to web tier, only allow database traffic from web tier → DB tier.

5. **Secure Remote Access**  
   - Instead of exposing SSH via LB, use **Azure Bastion** for secure RDP/SSH inside the portal without exposing ports to the public internet.  
