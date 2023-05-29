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
   - In main.tf file we need to call the resouce group module and variable values are hard-coded in `terraform.tfvar` file.

   <img width="1126" alt="Screenshot 2023-05-29 at 3 00 43 PM" src="https://github.com/Sankeerth-Chillamcharla/assignment-2/assets/46291282/5dbb97e1-2459-44b1-b643-755fb9e1123f">
   
## Vnet 
   - 




