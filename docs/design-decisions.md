# Design Decisions

## Hub-and-spoke

The topology separates shared/management capability from application and data workloads.

## Addressing

| Network | Address range | Example subnet |
| --- | --- | --- |
| Hub | 10.0.0.0/16 | 10.0.1.0/24 management |
| App spoke | 10.10.0.0/16 | 10.10.1.0/24 application |
| Data spoke | 10.20.0.0/16 | 10.20.1.0/24 data |

Ranges do not overlap, leaving room for additional subnets.

## Security groups

- direct Internet inbound traffic is explicitly denied
- hub-to-app traffic is allowed as a simple management example
- app-to-data inbound is restricted to example TCP ports 1433 and 443

In production, rules would be derived from documented application flows and tested with Network Watcher / effective security rules.

## Peering

Both spokes are peered with the hub in both directions. Spoke-to-spoke connectivity is not created directly in this lab.

## Not included

To keep the lab deployable and focused, this version does not provision:

- Azure Firewall
- VPN/ExpressRoute gateways
- DNS Private Resolver
- Bastion
- private endpoints
- route tables / NVA routing

Those are documented as future enhancements.
