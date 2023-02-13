validate:
	terraform init
	terraform validate
	terraform plan

build:
	terraform init
	terraform validate
	terraform plan
	terraform apply --auto-approve

destroy:
	terraform init
	terraform destroy --auto-approve

	