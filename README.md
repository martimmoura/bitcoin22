# bitcoin22
Build, cicd for bitcoin22

Comments:

1. See btc22/ dir for Dockerfile.
2. The resources are located in k8s/ , depends on ecr repo that hosts the image (created in infrastructure/cluster/ )
3. See .github/workflows/ for the pipeline definitions.
    -  infrastructure/prod-ci/ contains necessary infrastructure for authentication, push to ecr and deployment
    -  infrastructure/cluster/ created an EKS cluster and basic networking setup with basic boilerplate aws provided terraform modules, ecr repo. This came from a need to have a cluster to deploy to without using minikube or similar.

4,5. See count_logs/ for code and sample input.

6. See infrastructure/prod-ci/ . Added extra permissions to the role to be able to use it for CI. Everything else is as described.

todo:

- app ingress (for it to be a "listen node")
- semver in the pipelines with corresponding image tagging (dont use :latest for app)
- create k8s role+rolebinding to sa linked to prod-ci IAM role in aws-auth configmap (currently iam role maps to system:masters, see infrastructure/cluster/k8s_dependencies)
- Have the pipeline run the terraform modules too
    - Have to create new role for infrastructure cicd, create the backend for the remote state on s3
- clean up code 