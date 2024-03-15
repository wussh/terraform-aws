init:
	terraform init

plan:
	terraform plan -var-file=production.tfvars

apply:
	terraform apply -var-file=production.tfvars -auto-approve

destroy:
	terraform destroy -var-file=production.tfvars -auto-approve

.PHONY: init plan apply destroy
