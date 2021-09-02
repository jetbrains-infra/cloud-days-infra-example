# ATTENTION

The deployment project relies on terraform workspace feature. Please create workspace for each branch if you want to 
deploy an instance.

Exists deployment
```shell
terraform workspace list
teraform workspace select master
```

New deployment
```shell
terraform workspace new myfeature
```

# Deployment

```shell
export TF_VAR_build=23
export TF_WORKSPACE=master
terraform apply
```