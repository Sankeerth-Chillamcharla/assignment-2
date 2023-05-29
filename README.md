# Assignment-2

## Cloud Architecture Diagram

![image](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/180e970a-4508-4117-9ecb-90d391d404a3)


## Prerequisite

- Terraform Installation and setup, refer the [Terraform installation](https://learn.microsoft.com/en-us/azure/developer/terraform/quickstart-configure)
- Make sure that we have a active azure account wih admin right
- Terraform to Azure Authentication
  - Method 1
      - To Install Azure CLI, refer [install the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) 
        ``` 
        az login 
        ```
       - Set up service principal credentials in environment variables, [Terraform and Azure authentication scenarios](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash)
   - Method 2
     - Update the service principal credentials in `prodiver.tf` file `NOTE`
    
       ``` 
        subscription_id   = "<azure_subscription_id>"
        tenant_id         = "<azure_subscription_tenant_id>"
        client_id         = "<service_principal_appid>"
        client_secret     = "<service_principal_password>"
        ```
       `NOTE:` Exposing the credentials is not recommended method.
       
## Store Terraform state in Azure Storage 

- Login to Azure portal and click on cloud shell and upload the `remote-state.sh` file and change the filr permission, to configure the Azure storage account and container to store the remote state file.
- Ouput of `remote-state.sh` 

![Screenshot 2023-05-29 at 1 05 34 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/c24cc1d6-2a12-40dc-82db-7f0c042bfebd)

![Screenshot 2023-05-29 at 1 06 07 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/b43f31f9-e77b-4e71-84ea-965a7f6e980c)

- Add the storage account deatils in `provider.tf`
  ```
  backend "azurerm" {
    resource_group_name  = "RG-XYZ-CROP-TERRAFORM"
    storage_account_name = "xyzcropterraform30875"
    container_name       = "tfstatefile"
    key                  = "terraform.tfstate"
  }
  
  ```
  
## Usage

- Resource block code has been developed in to parent and child modules, along with modules we have another `.tf` file are available in project directory

  - `provider.tf` this file will contain the all providers information whic we are using in our project
  - `variable.tf` this file will contain the input variables to pass certain values from outside of the configuration or module.
  - `locals.tf` this file will contain the local variables are declared using the locals block. The values can be hard-coded or be a reference to another variable or resource.
  - `output.tf` this file will contain the output variables, to provide the resource information once done with creation
  - `settings.tf` this file will contain the terraform version which support the current script. 
  - `terraform.tfvar` this file will contain the hard-coded variable value. 
  - `immutable.tf` this file will contain the immutable ifra code

## Resource group 

   - Using the resource group module to creaet the multiple Resource groups, but its required the group name and location, these two variable values are hardcoded in the `terraform.tfvar` file.
   - Resource group name `RG-15FIVE-WBAPP`, its  module name `ResourceGroup`, these are the reference `module.ResourceGroup.rg-name` and `module.ResourceGroup.rg-location` to call output variables to refer another modules
   
   <img width="1126" alt="Screenshot 2023-05-29 at 3 00 43 PM" src="https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/5dbb97e1-2459-44b1-b643-755fb9e1123f">
   
## Vnet 
   - Vnet module contain the child module as subnet, nsg and nsg-rules. To create Vnet we requires resource resource group, location and cidr range, for resource group name and location values are calling form resource group module. 
   - CIDE range value is defind in `terraform.tfvar`

   <img width="1227" alt="Screenshot 2023-05-29 at 3 57 22 PM" src="https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/61a76513-9efd-4e45-a9ea-23f9464766d2">
   
   - Based on the vnet, we are going th create the subnet, in our case we need 3 subntes, 3 Network security groups and NSG asscioation with subntes, along with NSG rules. 

   ### Subnet Creation
  ![Screenshot 2023-05-29 at 4 03 43 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/6f98276d-c7c5-4875-94b0-9a6aee866125)
   ### NSG Creation
  ![Screenshot 2023-05-29 at 4 06 13 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/b8d36b12-7f41-406f-9abc-745b250e4ce6)
   ### NSG Asscioation with subnets
  ![Screenshot 2023-05-29 at 4 07 16 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/8d98f9dd-3e1a-48e5-aabd-ced883a60aae)
   ### Nsg Rules Creation
   - Nsg rules are listed in the `locals.tf`, this file and ngs-rules module are use full to create nsg-rules

  ![Screenshot 2023-05-29 at 4 12 22 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/6cfd60ee-53c9-4a66-94aa-7ce2e5075a3f) ![Screenshot 2023-05-29 at 4 11 41 PM](https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/8da95c80-3c92-4adc-a2f0-cc504d8c432d) 

   
 

