# Terraform

## what is Terraform?
- terraform is open source IAC (infrastructure as a code) tool , made by Hashicrop.

## Terraform language
- Terraform supports HCL (Hashicrop code language) and JSON.
- Extension for the HCL is .tf and for json .tf.json.
- Terraform supports data types as,
    -  String : ex. "abcd123"
    - Number : ex. 12345
    - Bool : ex. True/false, 0/1
    - List : ex. ["mango", "bannana", "apple"]
    - Map/Dictionary : ex. {
        name = "vishal"
        city = "pune"
    }
- Terraform supports {} to represents the block

- Terraform configuration block types:-
    - provider : configure block types
    - Resource : configure new resource
    - data : configure existing resource
    - Variable : to define variables
    - output : to get output
    - Terraform : to configure Terraform
    - modules : to call terraform modules.

    # Terraform installation.
    <!-- wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update
    sudo apt install terraform
    terraform --version -->

# General Terraform syntax
```shell
# <block_type> <resource_type> <resource_name> {

# }
```
## Terraform lifecycle
- terraform init :- load modules , all scripts check syntx , backend load , configure          terraform  block, losd providers
- terraform plan :- it will show blueprint of how the infrastructure configuration will look like after apply
- terraform apply :- it will apply all configuration.
- terraform destroy :- it will destroy all the infr/resources.

