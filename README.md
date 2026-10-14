# Turkish Airlines (THY) Enterprise Network & Active Directory Governance Lab

A hybrid enterprise network and security simulation modeled after Turkish Airlines (THY) IT infrastructure standards. This project combines hardware-level routing, extended access control policies, centralized identity management, and Group Policy enforcement across regional branches.

<p align="center">
  <img src="https://github.com/user-attachments/assets/751256cf-c168-4d2a-9efd-bab435ef902f" alt="THY Enterprise Network Topology" width="500" />
</p>

## Executive Summary

- **Hardware & Routing Layer (Cisco Packet Tracer):** Modeled a Hub-and-Spoke WAN topology connecting Headquarters (HQ), the Istanbul Management Station, and the Erzurum Regional Branch through serial DCE/DTE links.
- **Virtualization Layer (Oracle VM VirtualBox):** Configured an isolated internal network (`THY-Agi`) with promiscuous mode enabled, hosting Windows Server 2019 and Windows 10/11 endpoints.
- **Identity & Governance Layer (Windows Server Active Directory):** Established a hierarchical Organizational Unit (OU) structure under `thy.local`, implementing Role-Based Access Control (RBAC) principles and Group Policy Object (GPO) enforcement.

---

## Architecture & Topology Design

### Hub-and-Spoke WAN Topology

```text
                 +-----------------------------------+
                 |           THY-HQ-Router           |
                 |       (Ankara / Istanbul HQ)      |
                 +-----------------+-----------------+
                                   |
               [ Serial DCE/DTE Redundant WAN Links ]
                                   |
             +---------------------+---------------------+
             |                                           |
    +--------+---------+                       +---------+--------+
    | Istanbul-Router  |                       | Erzurum-Router   |
    | Istanbul-Manager |                       | Erzurum-Client   |
    |   10.0.3.0/24    |                       |   10.0.1.0/24    |
    +------------------+                       +------------------+
```

### Hub-and-Spoke WAN & Zero-Trust Traffic Inspection

- Direct horizontal communication between the Erzurum and Istanbul branches is restricted by security access control policies.
- Inter-branch traffic is designed to traverse the central HQ router for centralized inspection, IDS/IPS analysis, and firewall enforcement, subject to the configured routing and security policies.
- The topology separates regional network segments while establishing a centralized enterprise backbone.

---

## Key Implementations & Security Controls

### 1. Zero-Trust Branch Isolation via Extended ACL

To enforce branch isolation and mitigate lateral movement risks, an inbound Extended Access Control List (ACL), `THY_Siber_Guvenlik`, was applied to the Erzurum router interface (`GigabitEthernet0/0`).

- **Traffic Restriction:** Explicitly denies ICMP traffic originating from Erzurum toward the Istanbul management subnet (`10.0.3.0/24`).
- **Data Center Access:** Permits the configured administrative traffic destined for the central Data Center subnet (`10.0.2.0/24`).
- **Validation:** CLI tests reported 0% packet loss toward the Data Center and 100% timeout loss (`Request timed out`) toward the restricted management station.

### 2. Principle of Least Privilege (PoLP) & RBAC

Administrative access boundaries were configured to prevent branch station managers, such as `THY\azra` and `THY\mudur`, from inheriting unauthorized domain-level privileges.

- **Access Restrictions:** Managerial accounts received explicit `Access Denied` responses when attempting to access protected server shares, including `\\10.0.100.10\sysvol` and `\\10.0.100.10\netlogon`.
- **Policy Validation:** OU mapping and Group Policy application were examined using `whoami /fqdn` and `gpresult /r` (Resultant Set of Policy reporting).
- **Security Objective:** Apply least-privilege principles by separating ordinary user permissions from domain-level administrative rights.
<p align="center">
    <img width="760" height="627" alt="image" src="https://github.com/user-attachments/assets/168995d6-99dc-4440-bda5-8eff59028dad" />
</p>

### 3. Air-Gapped GPO Wallpaper Deployment

- Corporate visual assets were packaged into an `.ISO` image and mounted directly to the virtual server's storage controller to support an isolated lab environment.
- Assets were distributed through Group Policy using a Universal Naming Convention (UNC) path, such as `\\10.0.100.10\THY_Gorsel\...`.
- Read-only share permissions were configured for the `Everyone` group according to the lab's deployment requirements.
- Policy application was tested across client workstations to verify centralized desktop background management.

### 4. Layer 2 / Layer 3 Discovery & Protocol Analysis

- Investigated initial ICMP packet timeouts in the context of Address Resolution Protocol (ARP) discovery and Layer 2 forwarding-table learning.
- Subsequent ping sequences achieved consistent connectivity, with 0% packet loss and sub-millisecond round-trip times in the simulated environment.
- Validated DNS A-record resolution for `thy.com.tr` to `10.0.2.10`.
- Tested access to the configured HTTP management portal from branch endpoints.

---

## Technologies & Tools

| Category | Technology & Tools |
|---|---|
| **Network Simulation** | Cisco Packet Tracer |
| **Virtualization Layer** | Oracle VM VirtualBox, Internal Network (`THY-Agi`) |
| **Directory & Identity** | Windows Server 2019, Active Directory Domain Services, DNS, GPO |
| **Client Operating Systems** | Windows 10 / Windows 11 Enterprise |
| **Network Security** | Cisco Extended ACLs, inbound traffic filtering |
| **Access Governance** | RBAC, Principle of Least Privilege (PoLP) |
| **Network Protocols** | TCP/IP, ICMP, ARP, DNS (Port 53), HTTP (Port 80) |
| **CLI & System Diagnostics** | Cisco IOS CLI, `netsh`, `ipconfig /flushdns`, `whoami /fqdn`, `gpresult /r` |

---

## Repository Artifacts

| File | Type | Description |
|---|---|---|
| [`Bulut_Cisco_Pacet.pkt`](./Bulut_Cisco_Pacet.pkt) | Simulation | Cisco Packet Tracer enterprise network topology |
| [`BulutBilisimProjeRaporu.pdf`](./BulutBilisimProjeRaporu.pdf) | Documentation | Comprehensive 37-page engineering analysis and lab report |
| [`tracerpacket_Kod_bulutbilisim.cfg`](./tracerpacket_Kod_bulutbilisim.cfg) | Configuration | Cisco router CLI configurations covering interfaces, static routes, and Extended ACLs |
| [`victualBox_cmd_BulutBilisim.bat`](./victualBox_cmd_BulutBilisim.bat) | Script | Windows network setup batch script covering IPv4, gateway, and primary DNS configuration |


---

## Documented Engineering Troubleshooting

### 1. Boot Loop Recovery

**Problem:** Virtual machines repeatedly restarted into the operating system installation wizard.

**Resolution:** Adjusted boot device priorities and detached the installation ISO after installation to allow the installed operating system to boot normally.

### 2. Domain Join Resolver Fix

**Problem:** Client machines returned `Domain Not Found` errors when attempting to join the Active Directory domain.

**Resolution:**

- Configured the primary DNS resolver to point to the domain controller at `10.0.100.10`.
- Flushed the DNS resolver cache using `ipconfig /flushdns`.
- Retested domain discovery and the domain join process.

### 3. UNC Path Migration

**Problem:** Group Policy wallpaper deployment failed when the configured image referenced a local filesystem path, such as `C:\...`.

**Resolution:** Replaced local filesystem references with UNC network paths accessible to domain workstations and verified the relevant share permissions.

---

## Testing & Validation Matrix

- [x] **Hub-and-Spoke WAN Topology:** Tested Layer 3 connectivity across Headquarters and regional branches.
- [x] **Extended ACL Inter-Branch Restriction:** Tested ICMP restrictions between Erzurum and Istanbul management subnets while preserving Data Center connectivity.
- [x] **Least-Privilege Access Controls:** Tested access restrictions for branch manager accounts on protected server shares.
- [x] **Active Directory & DNS:** Troubleshot domain discovery through DNS configuration and cache flushing.
- [x] **GPO Inheritance & Policy Verification:** Examined policy application using `gpresult /r` and user identity information using `whoami /fqdn`.
- [x] **Centralized Asset Deployment:** Tested ISO-based asset transfer and desktop background deployment through UNC network shares.
- [x] **Layer 2 / Layer 3 Diagnostics:** Investigated initial ARP-related connectivity delays and tested subsequent network reachability.

*The checklist reflects the reported lab activities. Keep an item checked in the public repository only if you have personally completed and verified the corresponding test.*

---

## Learning Outcomes

This project demonstrates practical experience with:

- Enterprise network topology design and routing fundamentals.
- Network segmentation and traffic filtering using Cisco Extended ACLs.
- Active Directory administration and centralized identity management.
- Group Policy configuration and centralized endpoint governance.
- Windows domain troubleshooting, DNS configuration, and UNC-based resource access.
- Virtualized network laboratories and systematic troubleshooting.
- Least-privilege access design and security-oriented infrastructure configuration.

---

## License & Disclaimer

This project is licensed under the [MIT License](./LICENSE). See the `LICENSE` file for the complete license terms.

> **Disclaimer:** This repository documents an independently developed educational simulation for technical demonstration purposes. It is not an official Turkish Airlines project and does not imply affiliation with, endorsement by, or access to Turkish Airlines' production infrastructure.

