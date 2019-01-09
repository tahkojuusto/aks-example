# AKS (Infrastructure as Code)

Source code for a simple one environment AKS using Terraform. For multi-environment cases, see Kari Marttila's [example here][1].

## Create AKS resource

Go to the directory `/main`. Create `terraform.tfvars` file with the contents shown in the file `example.terraform.tfvars`.

Run the following commands:

```sh
az login
terraform init
terraform plan
terraform apply
```

## Deploy

Create the container of your application. Push it to Azure Container Registry (ACR):

```sh
APP_NAME = "test-app"
ACR_NAME = "test-acr"

docker tag ${APP_NAME} ${ACR_NAME}.azurecr.io/${APP_NAME}
docker push ${ACR_NAME}.azurecr.io/${APP_NAME}
```

Replace missing values from Kubernetes configuration file `deployment.yaml`. Run the following commands in order to deploy the image:

```sh
ACR_NAME = "test-acr"

az acr login --name ${ACR_NAME}
kubectl apply -f deployment.yaml
```

[1]: https://github.com/karimarttila/azure