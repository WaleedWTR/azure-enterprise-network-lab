targetScope = 'resourceGroup'

param location string = resourceGroup().location

resource hubNsg 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: 'hub-management-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Deny-Internet-Inbound'
        properties: {
          priority: 4000
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource appNsg 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: 'app-spoke-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-Hub-Inbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: '10.0.0.0/16'
          sourcePortRange: '*'
          destinationAddressPrefix: '10.10.0.0/16'
          destinationPortRange: '*'
        }
      }
      {
        name: 'Deny-Internet-Inbound'
        properties: {
          priority: 4000
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource dataNsg 'Microsoft.Network/networkSecurityGroups@2025-01-01' = {
  name: 'data-spoke-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-App-Inbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: '10.10.0.0/16'
          sourcePortRange: '*'
          destinationAddressPrefix: '10.20.0.0/16'
          destinationPortRanges: [
            '1433'
            '443'
          ]
        }
      }
      {
        name: 'Deny-Internet-Inbound'
        properties: {
          priority: 4000
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource hub 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'hub-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'management'
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: hubNsg.id
          }
        }
      }
    ]
  }
}

resource app 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'app-spoke-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'app'
        properties: {
          addressPrefix: '10.10.1.0/24'
          networkSecurityGroup: {
            id: appNsg.id
          }
        }
      }
    ]
  }
}

resource data 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'data-spoke-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'data'
        properties: {
          addressPrefix: '10.20.1.0/24'
          networkSecurityGroup: {
            id: dataNsg.id
          }
        }
      }
    ]
  }
}

resource hubToApp 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  parent: hub
  name: 'hub-to-app'
  properties: {
    remoteVirtualNetwork: {
      id: app.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

resource appToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  parent: app
  name: 'app-to-hub'
  properties: {
    remoteVirtualNetwork: {
      id: hub.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

resource hubToData 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  parent: hub
  name: 'hub-to-data'
  properties: {
    remoteVirtualNetwork: {
      id: data.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

resource dataToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  parent: data
  name: 'data-to-hub'
  properties: {
    remoteVirtualNetwork: {
      id: hub.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

output hubVnetId string = hub.id
output appVnetId string = app.id
output dataVnetId string = data.id
