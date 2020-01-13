#!/bin/bash

resourcegroup="ase-functions"
rglocation="westeurope"
vnetname="ase-vnet"
vnetgatewayname="ase-vnet-gateway"
gatewaypublicipname="ase-gateway-public-ip"

az network public-ip create --name $gatewaypublicipname \
    --resource-group $resourcegroup \
    --allocation-method Dynamic


az network vnet subnet create \
    --address-prefixes 10.2.2.0/24 \
    --name GatewaySubnet \
    --resource-group $resourcegroup \
    --vnet-name $vnetname

az network vnet-gateway create --name $vnetgatewayname \
    --public-ip-addresses $gatewaypublicipname \
    --resource-group $resourcegroup \
    --vnet $vnetname \
    --address-prefixes 10.3.0.0/24 \
    --sku VpnGw1

#Need to configure P2S VPN for gateway
#https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal
#https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-rm-ps




