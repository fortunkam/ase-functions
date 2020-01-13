#!/bin/bash

resourcegroup=$1
asensgname=$2

#inbound rules

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n AllowAppServiceManagement454_455 --priority 100 \
    --source-address-prefixes "AppServiceManagement" --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "454-455" --access Allow \
    --protocol Tcp --description "All App Service Management from 454-455"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n AllowAzureLoadBalancer --priority 200 \
    --source-address-prefixes "AzureLoadBalancer" --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "16001" --access Allow \
    --protocol '*' --description "All Azure Load Balancer on 16001"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n AllowASESubnetToASESubnet --priority 300 \
    --source-address-prefixes "10.2.0.0/24" --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges '*' --access Allow \
    --protocol '*' --description "All ASE Subnet to ASE Subnet"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_HTTP --priority 400 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "80" --access Allow \
    --protocol '*' --description "Allow Http inbound"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_HTTPS --priority 500 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "443" --access Allow \
    --protocol '*' --description "Allow Https inbound"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_FTP --priority 600 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "21" --access Allow \
    --protocol '*' --description "Allow FTP inbound"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_FTPS --priority 700 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "990" --access Allow \
    --protocol '*' --description "Allow FTPS inbound"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_FTP_Data --priority 800 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "10001-10020" --access Allow \
    --protocol '*' --description "Allow FTP Data inbound"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_Remote_Debugging --priority 900 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "4016-4022" --access Allow \
    --protocol '*' --description "Allow Remote Debugging"

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Inbound_Web_Deploy --priority 1000 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "8172" --access Allow \
    --protocol '*' --description "Allow Web Publish"

#Outbound rules

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Outbound_HTTP --priority 100 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges 80 443 --access Allow \
    --protocol '*' --description "Outbound Http" --direction Outbound

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Outbound_Time_NTP --priority 200 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "123" --access Allow \
    --protocol '*' --description "Outbound NTP" --direction Outbound

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Outbound_DB --priority 300 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "1433" --access Allow \
    --protocol '*' --description "Outbound DB" --direction Outbound

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Outbound_Monitor --priority 400 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges "12000" --access Allow \
    --protocol '*' --description "Outbound Monitor" --direction Outbound

az network nsg rule create -g $resourcegroup --nsg-name $asensgname -n Outbound_ASE_Subnet --priority 500 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes "10.2.0.0/24" --destination-port-ranges '*' --access Allow \
    --protocol '*' --description "Outbound to ASE Subnet" --direction Outbound