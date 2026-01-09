$RESOURCE_GROUP=""
$VNET_NAME=""
az network vnet delete --resource-group $RESOURCE_GROUP --name $VNET_NAME

az group create --name rg-ita-az-104-vnet --location italynorth

az network public-ip create \
  --name- ip-public-1 \
  --resource-group rg-ita-az-104-vnet \
  --tags 'Learning=AZ-104' \
  --version IpV4 \
  --sku standard \
  --location italynorth \
  --allocation-method Static


az deployment group create \
  --name DeployVnet_1 \
  --resource-group rg-ita-az-104-vnet \
  --template-uri "https://raw.githubusercontent.com/gscaramuzzino/azure_by_doing/refs/heads/main/vnet/template.json" \
  --parameters vnetName=vnet-1 subnetName=sbnet-1 vnetAddressPrefix=10.0.0.0/16 subnetPrefix=10.0.0.0/20

az deployment group create \
  --name DeployVnet_2 \
  --resource-group rg-ita-az-104-vnet \
  --template-uri "https://raw.githubusercontent.com/gscaramuzzino/azure_by_doing/refs/heads/main/vnet/template.json" \
  --parameters vnetName=vnet-2 subnetName=sbnet-1 vnetAddressPrefix=11.0.0.0/16 subnetPrefix=11.0.0.0/20

az deployment group create \
  --name DeployVnet_3 \
  --resource-group rg-ita-az-104-vnet \
  --template-uri "https://raw.githubusercontent.com/gscaramuzzino/azure_by_doing/refs/heads/main/vnet/template.json" \
  --parameters vnetName=vnet-3 subnetName=sbnet-1 vnetAddressPrefix=12.0.0.0/16 subnetPrefix=12.0.0.0/20

  az network vnet peering create --name vnet-1_to_vnet-2 \
                                 --resource-group rg-ita-az-104-vnet \
                                 --vnet-name vnet-1 \
                                 --remote-vnet vnet-2 \
                                 --allow-forwarded-traffic true \
                                 --allow-vnet-access true

   az network vnet peering create --name vnet-1_to_vnet-2 \
                                   --resource-group rg-ita-az-104-vnet \
                                   --vnet-name vnet-2 \
                                   --remote-vnet vnet-1 \
                                   --allow-forwarded-traffic true

   az network vnet peering create --name vnet-2_to_vnet-3 \
                                  --resource-group rg-ita-az-104-vnet \
                                  --vnet-name vnet-2 \
                                  --remote-vnet vnet-3 \
                                  --allow-forwarded-traffic true \
                                  --allow-vnet-access false

    az network vnet peering create --name vnet-2_to_vnet-3 \
                                    --resource-group rg-ita-az-104-vnet \
                                    --vnet-name vnet-3 \
                                    --remote-vnet vnet-2 \
                                    --allow-forwarded-traffic true

  az group delete --name rg-ita-az-104-vnet


