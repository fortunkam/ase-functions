#!/bin/bash

resourcegroup="ase-functions"
rglocation="westeurope"
asename="mfase"
planname="ase-function-plan"
storageaccountname="asefunctionstorage"
functionname="mffunction"

# az appservice plan create -g $resourcegroup -n $planname \
#     --app-service-environment $asename --sku I1

#create a storage account (connected to vnet)

az storage account create -g $resourcegroup -n $storageaccountname
#Need to manually add vnet connection

az functionapp create -g $resourcegroup  -p $planname -n $functionname -s $storageaccountname
