﻿App Insight demo
# Create an MVC .NET application
dotnet new mvc -o videowebapp
# Add SDK to App Insights
cd videowebapp &&  dotnet add package Microsoft.ApplicationInsights.AspNetCore
# Deploy web app and generate data
dotnet publish -o pub
cd pub
zip -r site.zip *

# Deploy app using azure CLI
An Azure Account with valid subscrition is required for the demo.
#### Azure CLI must be installed
To install Azure CLI!: https://docs.microsoft.com/fr-fr/cli/azure/install-azure-cli 
#### Login to azure accound using the command:
az login
 
Use Terraform Project to create the required resource for the web app.
Sub-project: provision-terraform 
#### Provisiong result:
* Create Resource group.
* Create service Plan
* Create Web App with default setting.
* Create a log anlytics resource.
* Create App insight service.

** deploy App
az webapp deployment source config-zip \
    --src site.zip \
    --resource-group <resource-group-name > \
    --name <your-App-Service-name>
## Visualize insights using dashboard app insights.
