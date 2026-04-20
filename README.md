# Step-by-step Guide to Automating Docker Builds with AWS CodeBuild and Terraform
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
<img width="940" height="622" alt="1" src="https://github.com/user-attachments/assets/43bfc489-669b-4a36-9712-10aabf0f1629" />


- Push your docker-compose-app folder to a GitHub repository:
- Initialize a Git repository in docker-compose-app using the command-line git init
- Add your files buildspec.yml, app/, and docker-compose.yml to your repository using the command-line git add .
Commit your changes and push them to a new or existing GitHub remote repository using the command-line git commit -m “message”.
<img width="702" height="672" alt="2" src="https://github.com/user-attachments/assets/037a7d7f-fe2d-493d-ba05-792f01c7f11f" />

- Add the GitHub remote repository to your file system using the command-line git remote add origin <github-url>
<img width="858" height="121" alt="3" src="https://github.com/user-attachments/assets/0c17dcd3-f5a6-4b7c-bbf2-b959d5e89691" />

- Push your files to the GitHub remote repository  using the command-line git push origin <branch-name>
<img width="1002" height="192" alt="4" src="https://github.com/user-attachments/assets/ec758647-b1d0-4d0f-ad26-8443dcaa4386" />

- Check that your files have been pushed properly to your GitHub remote repository.
<img width="1361" height="722" alt="5" src="https://github.com/user-attachments/assets/e84d8223-1764-447b-8a5b-d4d2565eab3d" />




### Step 2: Update Terraform Configuration for ECR and CodeBuild
Now that we have created and pushed our application files to Github. We need to update our terraform configuration files to create an ECR repository (where our Docker images will be stored) and a CodeBuild project (which will build our images). This involves defining new AWS resources in our main.tf file. To complete Step 2, follow the instructions below : 
- Open your aws-docker-infra/main.tf file.
- Add the following resources to your main.tf file
<img width="731" height="492" alt="6" src="https://github.com/user-attachments/assets/e5644796-8581-46f1-8ca5-6faed83b9f72" />
<img width="1170" height="732" alt="7" src="https://github.com/user-attachments/assets/06220ea8-c1df-40c3-82b9-c7b1a2338ac2" />
<img width="873" height="759" alt="8" src="https://github.com/user-attachments/assets/8d0d90a7-0ffe-4ec6-ae2d-0ebe689052c7" />

- Update your aws-docker-infra/variables.tf file to include the new variables for CodeBuild.
<img width="857" height="218" alt="9" src="https://github.com/user-attachments/assets/e93cc701-e4c5-4183-82a3-819e8fef1d5c" />

- Save main.tf and variables.tf

### Step 3: Apply Terraform Changes for ECR and CodeBuild
We have our application code files and updated the terraform configuration files to create the ECR repository, the IAM role for CodeBuild, and the CodeBuild project itself in your AWS account. We will now apply the changes with terraform. To complete Step 3, follow the instructions below : 
- Open your command line or terminal and navigate to your aws-docker-infra folder.
- Run terraform init again to ensure all new provider requirements are met (especially for data "aws_caller_identity").
- Run terraform plan to review the new resources that will be created. You should see plans to add ECR, IAM role/policy, and CodeBuild resources.
<img width="972" height="857" alt="10" src="https://github.com/user-attachments/assets/ca807d2a-7155-4255-9c5e-927b472deb36" />
<img width="668" height="855" alt="11" src="https://github.com/user-attachments/assets/068dbedb-eaac-4cc2-a34d-1ed57e49c6f1" />
<img width="795" height="846" alt="12" src="https://github.com/user-attachments/assets/67ac5fa6-6caa-4f3e-ab01-ae2223b17ae3" />
<img width="645" height="855" alt="13" src="https://github.com/user-attachments/assets/feba694f-5c59-49a6-baff-4eae44bf1ad7" />
<img width="663" height="855" alt="14" src="https://github.com/user-attachments/assets/4bd53bd0-4b92-45a8-b3a4-944e8c361c5e" />
<img width="1103" height="844" alt="15" src="https://github.com/user-attachments/assets/9e33e8d6-814e-4896-b117-2a727320b906" />

- If the plan looks correct, run terraform apply to provision these resources. Type yes when prompted.
This process will create the ECR repository and the CodeBuild project. It might take a few minutes.
<img width="990" height="853" alt="16" src="https://github.com/user-attachments/assets/32536b54-07ad-4bba-921b-d10ff9dc6785" />
<img width="679" height="857" alt="17" src="https://github.com/user-attachments/assets/c7e7dca4-0248-4be2-89b6-fbe00af82cc1" />
<img width="767" height="853" alt="18" src="https://github.com/user-attachments/assets/c74f2c26-bd3a-4d65-b61c-689cea9512b2" />
<img width="605" height="860" alt="19" src="https://github.com/user-attachments/assets/5acbdf31-941f-4e08-972c-fa195dbdc606" />
<img width="619" height="856" alt="20" src="https://github.com/user-attachments/assets/10dba647-ad7c-44c2-8b3f-b8bf9d1d8715" />
<img width="951" height="854" alt="21" src="https://github.com/user-attachments/assets/e627d1f5-b477-4ec5-bd1a-4b5213dbf338" />

### Step 4: Trigger Your First Automated Build
With CodeBuild set up, you can now trigger a build. This will tell CodeBuild to fetch your code from GitHub, run the buildspec.yml instructions, and push your Docker image to ECR. To complete Step 4, follow the instructions below : 
- Before starting the build, we need to update the code build role to append to it CloudWatchLogsFullAccess permission. This will allow us to check CloudWatch Logs for troubleshooting issues.
- Open the AWS Management Console in your web browser. Go to IAM Roles –-> codebuild-my-flask-app-role –-> Permissions –-> Add permissions –-> Attach policies –-> Select CloudWatchFullAccess –-> Add permission.
<img width="1414" height="620" alt="25" src="https://github.com/user-attachments/assets/d84326f4-75c2-470f-b64d-c171f8ded246" />

- To initiate the codebuild, Search for "CodeBuild" and go to the CodeBuild service. On the left navigation, click "Build projects."
- Find your project named my-flask-app-build and click on it.
- Click the "Start build" button in the top right corner.
<img width="1388" height="436" alt="22" src="https://github.com/user-attachments/assets/236ed0ad-ee85-4506-aa1f-ba7e85ef7ef6" />

**Note** : You can leave the default settings and click "Start build" again. CodeBuild will start a new build. You can monitor its progress in the "Build history" section by clicking on the "Phase details" and "Logs" tabs.
<img width="1338" height="408" alt="31" src="https://github.com/user-attachments/assets/e34141b8-02a0-465c-8bdb-3c1620d2e5b8" />

**Error 1** : Starting the build failed. The error below shows that the CodeBuild can not find the buildspec.yml file. 
<img width="1353" height="456" alt="23" src="https://github.com/user-attachments/assets/2818d3fd-1a29-4227-b9af-b5c8ea1402e8" />
<img width="1038" height="369" alt="26" src="https://github.com/user-attachments/assets/389c58a7-9d72-45bc-9bef-6194b247a7a8" />

**Troubleshooting Error 1** : 
- we will check first if the Github accounts credentials are set up.
- We need to connect the Github Account to the codebuild project.
- Then check our Terraform configuration files.
- Set up Github account credentials in Codebuild
<img width="839" height="725" alt="32" src="https://github.com/user-attachments/assets/78147213-8564-4c2e-b6e0-2a34b62cb65d" />
<img width="793" height="425" alt="33" src="https://github.com/user-attachments/assets/2430e081-01aa-4d16-915d-4105cea5fdc3" />


- Specify the Github branch on Terraform configuration file where the files are pushed
<img width="893" height="610" alt="27" src="https://github.com/user-attachments/assets/3d7e1f80-20c8-4680-bdaf-f0589474b4a7" />
<img width="671" height="288" alt="35" src="https://github.com/user-attachments/assets/39f921b6-3361-48a8-b45f-5e207362fb0d" />


- Apply the Terraform code changes with terraform apply command-line
<img width="1075" height="803" alt="38" src="https://github.com/user-attachments/assets/f33fc4f2-a4d7-4ca3-8358-d37ed0f43d71" />

- Wait for the build to succeed. This might take 5-10 minutes for the first run as it pulls base images etc.
<img width="1429" height="575" alt="43" src="https://github.com/user-attachments/assets/55cedc30-fec6-4606-974c-49494ff23c5b" />

<img width="1022" height="677" alt="Screenshot 2025-07-29 at 12 02 06 AM" src="https://github.com/user-attachments/assets/a9d4c99e-d344-4974-aca9-70d36115ae20" />
<img width="984" height="727" alt="Screenshot 2025-07-29 at 12 02 30 AM" src="https://github.com/user-attachments/assets/1c3e5a46-10fa-4b20-92a3-c31b1e73f09b" />
<img width="975" height="735" alt="Screenshot 2025-07-29 at 12 02 49 AM" src="https://github.com/user-attachments/assets/f47c86d4-8c85-45a8-acd1-dd23d4cd6059" />

- Verify the Docker image in ECR:
- Once the build succeeds, search for "ECR" in the AWS Console and go to Elastic Container Registry.
Click on "Repositories."
- You should see my-flask-app-repo. Click on it.
- You should now see your Docker images listed, tagged with latest and a short commit hash. This confirms your automated build and push to ECR were successful!
<img width="1408" height="345" alt="44" src="https://github.com/user-attachments/assets/d8268087-77ed-4130-ada3-175c9fdcb9b1" />
<img width="1418" height="343" alt="45" src="https://github.com/user-attachments/assets/d0b2ac74-1450-4481-852b-548726439d92" />


### Step 5 : Clean Up (Optional but Recommended)
To avoid ongoing charges, it's good practice to destroy the CodeBuild and ECR resources when you are done. To complete Step 5, follow the instructions below : 
- Go back to your local terminal. Navigate to your aws-docker-infra folder.
- Run the Terraform destroy command Type yes and press Enter to confirm.
- This will remove the ECR repository, CodeBuild project, and the IAM role/policy. 
<img width="981" height="818" alt="46" src="https://github.com/user-attachments/assets/09735feb-7eef-4113-aca9-fb80b33e968b" />
<img width="750" height="814" alt="47" src="https://github.com/user-attachments/assets/8d37382d-add5-4ba0-9540-5edf54cd65bd" />
<img width="980" height="810" alt="48" src="https://github.com/user-attachments/assets/19d87c62-f549-4a18-b6f1-5443e128cb5c" />
<img width="865" height="808" alt="49" src="https://github.com/user-attachments/assets/d53867db-3e00-4c34-b04e-c9add314c142" />
<img width="865" height="808" alt="49" src="https://github.com/user-attachments/assets/d9e3eac6-374a-4a3c-a30a-e30319da4492" />
<img width="863" height="815" alt="51" src="https://github.com/user-attachments/assets/920dfa3f-a843-4f2d-91b9-d1ce9df7a39d" />
<img width="965" height="814" alt="52" src="https://github.com/user-attachments/assets/b08185f2-aa10-41ca-b05e-0cf0de14e29e" />
<img width="1139" height="711" alt="53" src="https://github.com/user-attachments/assets/84a5f718-8dbd-42b6-a47a-e324df16f5fc" />
<img width="999" height="577" alt="54" src="https://github.com/user-attachments/assets/d9af0334-3e39-4dce-8117-78a55ee4ad9e" />

- Check your infrastructure on AWS Console
- **VPC**
<img width="1418" height="344" alt="55" src="https://github.com/user-attachments/assets/fb26cd49-3a24-4493-84b2-53279d10bd73" />

- **EC2 Instance**
<img width="1421" height="405" alt="56" src="https://github.com/user-attachments/assets/8ab958fe-1ebd-4f19-ab0c-5ef2ac699f8f" />


- **ECR Repository** 
<img width="1397" height="315" alt="57" src="https://github.com/user-attachments/assets/1c55b4fd-8b68-4550-987d-55bc751fb71a" />

- **Build project in CodeBuild**
<img width="1354" height="407" alt="58" src="https://github.com/user-attachments/assets/6c308fdd-826f-453f-a627-816339d88a3e" />


### Summary
This breakdown provides a step-by-step guide to automate the process of building and pushing Docker images using AWS CodeBuild and Terraform. By completing this lab, we had an overview on how to : 
- How to use AWS CodeBuild to automate Docker image builds.
- How to store Docker images in AWS Elastic Container Registry (ECR).
- How to use Terraform to provision CodeBuild and ECR resources.
- How to trigger a CodeBuild project.
-  What Continuous Integration (CI) is and its benefits.

This process provides a solid foundation for implementing CI/CD pipelines, enabling faster development cycles, consistent image builds, and seamless deployments. Automating this process not only improves efficiency but also reduces the risk of human error, accelerates development cycles, and lays the foundation for a robust CI/CD pipeline.
