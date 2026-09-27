# Future Enterprise Pattern

A more complete version of this lab could add:

- Azure Firewall in the hub
- UDRs forcing spoke egress through the firewall
- Azure Bastion
- private DNS zones and DNS Private Resolver
- private endpoints for PaaS services
- DDoS Network Protection where justified
- VPN or ExpressRoute connectivity
- central Network Watcher / flow telemetry
- Azure Policy controls for approved network patterns
- separate subscriptions for hub and workload spokes

The purpose of the current repo is to make the core routing and segmentation model understandable before layering on additional services.
