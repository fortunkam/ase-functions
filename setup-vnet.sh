#!/bin/bash

resourcegroup="ase-functions"
rglocation="westeurope"

az group create --location $rglocation --name $resourcegroup

#Create a VNet
vnetname="ase-vnet"

az network vnet create \
  --name $vnetname \
  --resource-group $resourcegroup \
  --location $rglocation \
  --address-prefix 10.2.0.0/16


asensgname="ase-nsg"

#Add an NSG on the ASE vnet
az network nsg create -g $resourcegroup -n $asensgname

#Add NSG Rules (seperate script)
./setup-nsg-rules.sh "$resourcegroup" "$asensgname"

#Add a subnet for the ASEs

az network vnet subnet create \
    --address-prefixes 10.2.0.0/24 \
    --name ase \
    --resource-group $resourcegroup \
    --vnet-name $vnetname \
    --network-security-group $asensgname

#Add a subnet for the debug VMs

az network vnet subnet create \
    --address-prefixes 10.2.1.0/24 \
    --name vms \
    --resource-group $resourcegroup \
    --vnet-name $vnetname



