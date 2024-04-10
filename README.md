ATG project

AWS + Terraform + Gitlab

The main idea of the project is to facilitate the management or updates of a large number of clients who have the same infrastructure, such as EC2 instances. In this project, all subprojects will take the main Terraform code from a repository registry and add their own variables to it or update the infrastructure according to the specific client's needs.

Terraform:
The main source code is located in a GitLab repository named "infrastructure-registry." After creating the main source code and adding Terraform infrastructure for three different environments, such as development, staging, and production.

GitLab Pipeline:
After creating the repositories, it is necessary to grant permissions to download specific branches from the client's repository. After that, the pipeline will automatically download the version of the commit that has a specific tag in its name, for example, "latest_version."

This approach significantly simplifies the creation of new clients and setting up a development environment for local development, as well as updating all clients by making changes only in one repository.