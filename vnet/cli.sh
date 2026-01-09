$RESOURCE_GROUP=""
$VNET_NAME=""
az network vnet delete --resource-group $RESOURCE_GROUP --name $VNET_NAME


az group create --name rg-eastus-az-104-vnet --location eastus

az deployment group create \
  --name DeployVnet \
  --resource-group rg-eastus-az-104-vnet \
  --template-file
  --parameters