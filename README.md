# Azure Enterprise Network Lab

![Bicep validation](https://github.com/WaleedWTR/azure-enterprise-network-lab/actions/workflows/bicep.yml/badge.svg)

A hub-and-spoke Azure networking portfolio lab demonstrating segmentation, Network Security Groups and bidirectional VNet peering.

> **Portfolio note:** This is a synthetic lab design. Address ranges and naming are illustrative.

## Architecture

```text
                   +------------------+
                   |    Hub VNet      |
                   |   10.0.0.0/16    |
                   |                  |
                   | Management       |
                   | 10.0.1.0/24      |
                   +--------+---------+
                            |
                    VNet peering
                     /          \
                    /            \
       +-----------+              +-----------+
       | App Spoke |              | Data Spoke|
       |10.10.0.0/16              |10.20.0.0/16
       |           |              |           |
       |10.10.1/24 |              |10.20.1/24 |
       +-----------+              +-----------+
```

## What this project demonstrates

- hub-and-spoke design
- subnet segmentation
- VNet peering
- Network Security Groups
- explicit east-west traffic intent
- Bicep Infrastructure as Code
- validation in GitHub Actions
- operational testing guidance

## Build

```bash
az bicep build --file infrastructure/main.bicep
```

## Deploy

```bash
az deployment group create \
  --resource-group <lab-rg> \
  --template-file infrastructure/main.bicep
```

## Documentation

- [Design decisions](docs/design-decisions.md)
- [Network test plan](docs/test-plan.md)
- [Troubleshooting guide](docs/troubleshooting.md)
- [Future enterprise pattern](docs/future-enterprise-pattern.md)
- [Technical references](docs/references.md)

## Skills demonstrated

**Azure Networking · VNets · Subnets · NSGs · Peering · Bicep · Network Segmentation · Cloud Architecture**
