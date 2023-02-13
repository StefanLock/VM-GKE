# VM-GKE

## Prerequisites

1. Set up a Google cloud account
2. [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
3. Install gcloud.

Ensure the following APIs ar enabled:
1. Compute
2. BigQuery

## Getting started

__make validate__

running this will simply validate your terraform code and show you the plan.

__make build__

running this will validate but also apply your code autonomously.

__make destroy__

running this will destroy the infrastructure

_WARNING:_  This is set to auto approve  
