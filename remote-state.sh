#!/bin/bash
RESOURCE_GROUP_NAME=RG-XYZ-CROP-TERRAFORM
STORAGE_ACCOUNT_NAME=xyzcropterraform$RANDOM
CONTAINER_NAME=tfstatefile
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location westeurope
# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
# Enable the versioning 
az storage account blob-service-properties update \
    --resource-group $RESOURCE_GROUP_NAME \
    --account-name $STORAGE_ACCOUNT_NAME  \
    --enable-versioning true
echo $RESOURCE_GROUP_NAME
echo $STORAGE_ACCOUNT_NAME
echo $CONTAINER_NAME