@description('The location that resources will be deployed to. Default is the location of the resource group')
param location string = resourceGroup().location

@description('Specifies the name of the App Service Plan')
param appServicePlanName string

@description('Specifies the name of the Application Insights resource')
param appInsightsName string

@description('Specifies the name of the Cosmos DB account')
param cosmosDbAccountName string

@description('Specifies the name of the Cosmos DB database')
param cosmosDbDatabaseName string

@description('Specifies the name of the Key Vault resource')
param keyVaultName string

@description('Specifies the name of the App Configuration resource')
param appConfigName string

@description('Specifies the name of the Service Bus Namespace')
param serviceBusNamespaceName string

@description('Specifies the name of the Log Analytics workspace')
param logAnalyticsWorkspaceName string

@description('The timestamp that this template was last deployed')
param lastDeployed string = utcNow()

@description('Name of the Budget that will be created')
param budgetName string

@description('The email address to use for the budget')
param emailAddress string

var tags = {
  ApplicationName: 'Healthtrackr'
  Component: 'Infrastructure'
  Environment: 'Production'
  LastDeployed: lastDeployed
}
var budgetStartDate = '2023-01-01'

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'asp'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    tags: tags
  }
}

module appInsights 'modules/app-insights.bicep' = {
  name: 'appins'
  params: {
    appInsightsName: appInsightsName 
    tags: tags
    location: location
    logAnalyticsId: logAnalytics.outputs.logAnalyticsId
  }
}

module appConfig 'modules/app-config.bicep' = {
  name: 'appconfig'
  params: {
    appConfigurationName: appConfigName
    location: location
    tags: tags
  }
}

module budget 'modules/budget.bicep' = {
  name: 'budget'
  params: {
    budgetName: budgetName
    ownerEmailAddress: emailAddress
    startDate: budgetStartDate
  }
}

module cosmosDb 'modules/cosmos-db.bicep' = {
  name: 'cosmos-db'
  params: {
    appConfigName: appConfig.outputs.appConfigName
    cosmosDBAccountName: cosmosDbAccountName
    databaseName: cosmosDbDatabaseName
    keyVaultName: keyVault.outputs.keyVaultName
    location: location
    tags: tags
  }
}

module keyVault 'modules/key-vault.bicep' = {
  name: 'kv'
  params: {
    accessPolicies: [] 
    keyVaultName: keyVaultName
    tags: tags
    location: location
  }
}

module logAnalytics 'modules/log-analytics.bicep' = {
  name: 'law'
  params: {
    location: location 
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    tags: tags
  }
}

module serviceBus 'modules/service-bus.bicep' = {
  name: 'service-bus'
  params: {
    serviceBusNamespaceName: serviceBusNamespaceName 
    tags: tags
    location: location
  }
}

