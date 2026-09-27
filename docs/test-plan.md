# Network Test Plan

## Deployment validation

- Bicep builds without errors
- all three VNets deploy in the expected region
- address spaces do not overlap
- all four peering relationships show Connected
- NSGs are attached to intended subnets

## Connectivity tests

With test VMs or equivalent lab endpoints:

1. Verify hub -> app connectivity on an explicitly allowed flow.
2. Verify app -> data connectivity only on intended ports.
3. Verify an unapproved inbound flow is denied.
4. Verify there is no direct Internet inbound path created by the template.
5. Review effective security rules.
6. Review next-hop behaviour before adding custom routes.

## Operational checks

- review Network Watcher topology
- confirm NSG flow logging strategy if required
- document any rule changes
- validate cost before adding Firewall, Bastion or gateways
