
# **Deployment of Java application through Azure Devops Pipeline, Azure Repos, ACR, Azure Kubentes Service**

We have deployed banking application in capstone project1 using jenkins, github, dockerhub, ansible, kubernetes, we will take the same application and deploy through Azure Devops, Azure Repos, Azure container registry, Azure Kubentes Service.

## **1. Import the repository:**

We will create a new project in Azure DevOps and then go to Repo and click on Import a Repository

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.001.png)

We have already created gihub repo for the capstone1 project: <https://github.com/kotianrakshith/CapstoneProject1>

We will import this:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.002.png)

We can see after the import all the files are imported:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.003.png)

(Later we will delete all the files not needed ex. Jenkinsfile.)

## **2. Build the Java application**

We wiill go to pipeline and create a new pipeline:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.004.png)

In the first step we will chose repo as Azure Repos Git and then our repo:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.005.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.006.png)

Then we will chose maven and only chose package:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.007.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.008.png)

Then we will have our pipeline code till the build . 

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.009.png)

We will change our pool to our default pool as we are using our local machine to build(not yet authorized to use microsoft hosted agent)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.010.png)

Then we will save and run.This will be saved in the azure repo.

We see that run is completed sucessfully

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.011.png)

## **3. Build and push the image to azure container registry**

First let us create a container registry:

Go to container registries in azure portal:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.012.png)

Click create.Give a name and other details and click review and create:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.013.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.014.png)

Now we will go the pipeline and add the build and push to containe registry steps:

Edit the pipeline and add the task:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.015.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.016.png)

We will get below code to add:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.017.png)

We had to install docker in the local system to run this, but once done then it runs successfully:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.018.png)

Then we can see in the azure container registries that docker image is pushed:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.019.png)

## **4. Create Kubernetes cluster:**

We will go to kubernetes services in Azure DevOps and click create kubernetes cluster:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.020.png)

We will give the required details:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.021.png)

In integration settings we will integrate container registry and default log analytics workspace:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.022.png)

You can then review and create.

Once deployment is successful you should be able to see the cluster created

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.023.png)

## **5. Deploy the app to kubernetes:**

We will now edit the pipeline to add the kubernetes task:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.024.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.025.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.026.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.027.png)

To make the pipeline reusable we will add delete action below this code:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.028.png)

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.029.png)

We have added **continueOnError: true** so that it build can proceed even if this fails.(if there is no deployment/service it will fail)

After making few small changes in previous manifest file and the pipeline, our run was successful:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.030.png)

## **6. Check the deployment and access the app:**

In AKS, we can go to the workloads to see our deployment:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.031.png)

We can see that orbitbankapp is deployed.

In Services and ingresses, we can see that service is also deployed:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.032.png)

In this page we can see externalIP given.

We can access to required app page in

<http://20.81.109.230:8989/bank-api/swagger-ui.html>

(externalip:port/pagelink)

As you can see we are able to access:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.033.png)

And also navigate:

![](/readmeimages/Aspose.Words.7b8aed00-b14b-40f4-a100-e468ef6d0e61.034.png)

That completes this project. We have used the same code from capstone1 but we have used azure tools like Azure Devops, Azure Repos, Azure container registry, Azure Kubentes Service to achive the same results much easily.
