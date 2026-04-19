# Automating Docker Builds with AWS CodeBuild and Terraform
In modern DevOps workflows, automating the build and deployment process is essential for delivering applications efficiently and reliably. This lab is about automating Docker Builds with AWS CodeBuild and Terraform. By leveraging Terraform, we can define and provision our CodeBuild project, ensuring repeatability and consistency across environments. AWS CodeBuild serves as the continuous integration service that automatically compiles your source code, runs tests, and produces deployable artifacts, such as Docker images. 

This comprehensive step-by-step guide walks you through the process of Automating Docker Builds with AWS CodeBuild and Terraform. This involves automating the process of building Docker images using AWS CodeBuild, using Terraform as an infrastructure as code tool. The aim of this project is to learn : 
- What Continuous Integration (CI) is and its benefits.
- How to use AWS CodeBuild to automate Docker image builds.
- How to store Docker images in AWS Elastic Container Registry (ECR).
- How to use Terraform to provision CodeBuild and ECR resources.
- How to trigger a CodeBuild project.

## Prerequisites
- Have understood Docker, Docker Compose, and basic Terraform concepts with AWS.
- Have an AWS Account with sufficient permissions.
- Have Terraform installed and configured with AWS credentials.
- Create a private or public GitHub Repository and configure credentials : to push your docker-compose-app code. This is where CodeBuild will pull your source code from.

## Step-by-step instructions :
### Step 1: Prepare Your Application for CodeBuild and ECR
To automate Docker Builds with AWS CodeBuild and Terraform, we need to create a buildspec.yml file. It will tell CodeBuild how to build your Docker image. Also, instead of just building locally, we'll push our image to AWS's private Docker registry, Elastic Container Registry (ECR). To complete Step 1, follow the instructions below : 
- Go to your docker-compose-app folder.
- Create a new file named buildspec.yml in the application's root directory docker-compose-app folder.
- Open buildspec.yml and paste the following content.


- Push your docker-compose-app folder to a GitHub repository.
- Initialize a Git repository in docker-compose-app using the command-line git init
- Add your files buildspec.yml, app/, and docker-compose.yml to your repository using the command-line git add .
Commit your changes and push them to a new or existing GitHub remote repository using the command-line git commit -m “message”.
- Add the GitHub remote repository to your file system using the command-line git remote add origin <github-url>
- Push your files to the GitHub remote repository  using the command-line git push origin <branch-name>
- Check that your files have been pushed properly to your GitHub remote repository.




### Step 2: Update Terraform Configuration for ECR and CodeBuild
Now that we have created and pushed our application files to Github. We need to update our terraform configuration files to create an ECR repository (where our Docker images will be stored) and a CodeBuild project (which will build our images). This involves defining new AWS resources in our main.tf file. To complete Step 2, follow the instructions below : 
- Open your aws-docker-infra/main.tf file.
- Add the following resources to your main.tf file



- Update your aws-docker-infra/variables.tf file to include the new variables for CodeBuild.

- Save main.tf and variables.tf

### Step 3: Apply Terraform Changes for ECR and CodeBuild
We have our application code files and updated the terraform configuration files to create the ECR repository, the IAM role for CodeBuild, and the CodeBuild project itself in your AWS account. We will now apply the changes with terraform. To complete Step 3, follow the instructions below : 
- Open your command line or terminal and navigate to your aws-docker-infra folder.
- Run terraform init again to ensure all new provider requirements are met (especially for data "aws_caller_identity").
- Run terraform plan to review the new resources that will be created. You should see plans to add ECR, IAM role/policy, and CodeBuild resources.






- If the plan looks correct, run terraform apply to provision these resources. Type yes when prompted.
This process will create the ECR repository and the CodeBuild project. It might take a few minutes.






### Step 4: Trigger Your First Automated Build
With CodeBuild set up, you can now trigger a build. This will tell CodeBuild to fetch your code from GitHub, run the buildspec.yml instructions, and push your Docker image to ECR. To complete Step 4, follow the instructions below : 
- Before starting the build, we need to update the code build role to append to it CloudWatchLogsFullAccess permission. This will allow us to check CloudWatch Logs for troubleshooting issues.
- Open the AWS Management Console in your web browser. Go to IAM Roles –-> codebuild-my-flask-app-role –-> Permissions –-> Add permissions –-> Attach policies –-> Select CloudWatchFullAccess –-> Add permission.




- To initiate the codebuild, Search for "CodeBuild" and go to the CodeBuild service. On the left navigation, click "Build projects."
- Find your project named my-flask-app-build and click on it.
- Click the "Start build" button in the top right corner.

**Note** : You can leave the default settings and click "Start build" again. CodeBuild will start a new build. You can monitor its progress in the "Build history" section by clicking on the "Phase details" and "Logs" tabs.

**Error 1** : Starting the build failed. The error below shows that the CodeBuild can not find the buildspec.yml file. 


**Troubleshooting Error 1** : 
- we will check first if the Github accounts credentials are set up.
- We need to connect the Github Account to the codebuild project.
- Then check our Terraform configuration files.
- Set up Github account credentials in Codebuild


- Specify the Github branch on Terraform configuration file where the files are pushed


- Apply the Terraform code changes with terraform apply command-line

- Wait for the build to succeed. This might take 5-10 minutes for the first run as it pulls base images etc.

- Verify the Docker image in ECR:
- Once the build succeeds, search for "ECR" in the AWS Console and go to Elastic Container Registry.
Click on "Repositories."
- You should see my-flask-app-repo. Click on it.
- You should now see your Docker images listed, tagged with latest and a short commit hash. This confirms your automated build and push to ECR were successful!


### Step 5 : Clean Up (Optional but Recommended)
To avoid ongoing charges, it's good practice to destroy the CodeBuild and ECR resources when you are done. To complete Step 5, follow the instructions below : 
- Go back to your local terminal. Navigate to your aws-docker-infra folder.
- Run the Terraform destroy command Type yes and press Enter to confirm.
- This will remove the ECR repository, CodeBuild project, and the IAM role/policy. 











- Check your infrastructure on AWS Console
- **VPC**

- **EC2 Instance**


- **ECR Repository** 

- **Build project in CodeBuild**

### Summary
This breakdown provides a step-by-step guide to automate the process of building and pushing Docker images using AWS CodeBuild and Terraform. By completing this lab, we had an overview on how to : 
- How to use AWS CodeBuild to automate Docker image builds.
- How to store Docker images in AWS Elastic Container Registry (ECR).
- How to use Terraform to provision CodeBuild and ECR resources.
- How to trigger a CodeBuild project.
-  What Continuous Integration (CI) is and its benefits.

This process provides a solid foundation for implementing CI/CD pipelines, enabling faster development cycles, consistent image builds, and seamless deployments. Automating this process not only improves efficiency but also reduces the risk of human error, accelerates development cycles, and lays the foundation for a robust CI/CD pipeline.
