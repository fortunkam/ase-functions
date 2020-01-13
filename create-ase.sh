#!/bin/bash

resourcegroup="ase-functions"
rglocation="westeurope"
asename="mfase"
subnetname="ase"
vnetname="ase-vnet"

az appservice ase create --name $asename --resource-group $resourcegroup \
    --subnet $subnetname --vnet-name $vnetname \
    --front-end-sku I1 \
    --virtual-ip-type Internal \
    --ignore-network-security-group true \
    --no-wait

