# ebms-docker

basis is vul alle defaults in in ebms-admin.embedded.properties
copy jdbc driver en evt. truststore in image
en overschrijf met omgevingsspecifieke environment variables

```powershell
$envVars = @{
        'keystores_type'='AZURE'
        'azure_keyvault_uri'='https://xxxxx.vault.azure.net/'
        'azure_keyvault_tennantid'='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx'
        'azure_keyvault_clientid'='uri://app'
        'azure_keyvault_client_secret'='xxxxxxxxxxxxx'
        'client_keystore_defaultAlias'='keystore entry name'
        'keystore_defaultAlias'='keystore entry name'
        'ebms_jdbc_url'="jdbc:postgresql://${POSTGRESQL_SERVER_NAME}:5432/${DATABASE_NAME}"
        'ebms_jdbc_username'=''
        'ebms_jdbc_password'=''
        'https_verifyhostnames'='false'
}

New-AzContainerGroup `
    -ResourceGroupName myResourceGroup `
    -Name mycontainer2 `
    -Image xxxx.azurecr.io/ebms-adapter-bin:2.17.7-M8 `
    -RestartPolicy OnFailure `
    -EnvironmentVariable $envVars `
    -Port 8080,8000
```

[AZ docu New-AzContainerGroup](https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/new-azcontainergroup?view=azps-5.7.0)