# README
This project is a CI/CD pipeline to deploy a RoR (Ruby on Rails) application to Azure.
The pipeline consists of two workflows: a CI (Continuous Integration) and a CD (Continuous Deployment).
Focusing on the principle of 'fail fast,' if the initial tests in the CI workflow don't pass, then the deployment will not start.

Several checks are run on the code: RuboCop, RSpec, Brakeman, and Bundle Auditor.
The deployment workflow will then create the infrastructure in Azure with Terraform.
The application is containerized and then deployed to a web app.
