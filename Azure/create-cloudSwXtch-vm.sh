#!/bin/bash

# Script to create Ubuntu 20.04-LTS VMs in Azure
# Copyright (C) 2022 swXtch.io
# Permission to copy and modify is granted under the MIT license

if [ $# -ne 9 ]; then
    echo "Invalid number of arguments supplied."
    echo "usage: script <name> <rg> <vnetRG> <vnetName> <subnetCtrl> <subnetData> <vm_type> <admin> <key>"
    exit -1
fi

Name=$1
RG=$2
vnetRG=$3
vnetName=$4
subnetCtrl=$5
subnetData=$6
vm_type=$7
admin=$8
key=$9

echo
echo "Creating Stock Ubuntu 20.04 instances of type ${vm_type}"
echo "  NAME: ${Name}"
echo "  RG: ${RG}"
echo "  VNET: ${vnetRG}/${vnetName}[${subnetCtrl}:${subnetData}]"
echo "  ADMIN: ${admin}"
echo "  PUBLIC_KEY : ${key}"
echo
read -p "Press Y to continue:" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    az deployment group create --resource-group ${RG} --template-file azure-ubuntu-20_04-lts.json --parameters vmBaseName=${Name} vnetRG=${vnetRG} vnetName=${vnetName} subnetCtrl=${subnetCtrl} subnetData=${subnetData} virtualMachineSize=${vm_type} adminUsername=${admin} adminPublicKey="${key}"
else
    echo "Aborting"
fi
