#!/bin/bash

read -p 'Administrator Password for VM: ' pwd
resourcegroup="ase-functions"
rglocation="westeurope"
subnetname="vms"
vnetname="ase-vnet"

az vm create \
    --name apiserver \
    --resource-group $resourcegroup \
    --private-ip-address 10.2.1.4 \
    --vnet-name $vnetname \
    --subnet $subnetname \
    --image Win2019Datacenter \
    --admin-username AzureAdmin \
    --admin-password $pwd \
    --public-ip-address "" \
    --os-disk-name "apiserver-os-disk"