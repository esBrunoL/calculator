# Deployment Guide for Calculator App

## GitHub Repository Setup

1. **Create a new repository on GitHub:**
   - Go to https://github.com/new
   - Name: `flutter-calculator-app`
   - Description: `Professional Flutter calculator app with AWS deployment`
   - Make it public or private as preferred

2. **Connect local repository to GitHub:**
   ```bash
   cd "c:\Users\bruno\Documents\mobileApp\calculatorApp"
   git remote add origin https://github.com/YOUR_USERNAME/flutter-calculator-app.git
   git branch -M main
   git push -u origin main
   ```

## AWS Deployment Setup

### Prerequisites
- AWS CLI installed and configured
- Docker installed
- AWS account with appropriate permissions

### Step 1: Create AWS Infrastructure

1. **Deploy CloudFormation stack:**
   ```bash
   aws cloudformation create-stack \
     --stack-name calculator-app-infrastructure \
     --template-body file://cloudformation-template.json \
     --parameters ParameterKey=AppName,ParameterValue=calculator-app \
     --capabilities CAPABILITY_IAM \
     --region us-east-1
   ```

2. **Wait for stack creation:**
   ```bash
   aws cloudformation wait stack-create-complete \
     --stack-name calculator-app-infrastructure \
     --region us-east-1
   ```

### Step 2: Setup CodeBuild Project

1. **Create CodeBuild project:**
   ```bash
   aws codebuild create-project \
     --name "calculator-app-build" \
     --source type=GITHUB,location=https://github.com/YOUR_USERNAME/flutter-calculator-app.git \
     --artifacts type=NO_ARTIFACTS \
     --environment type=LINUX_CONTAINER,image=aws/codebuild/amazonlinux2-x86_64-standard:3.0,computeType=BUILD_GENERAL1_MEDIUM,privilegedMode=true \
     --service-role arn:aws:iam::YOUR_ACCOUNT_ID:role/codebuild-service-role
   ```

2. **Set environment variables in CodeBuild:**
   - `AWS_DEFAULT_REGION`: us-east-1
   - `AWS_ACCOUNT_ID`: Your AWS account ID
   - `IMAGE_REPO_NAME`: calculator-app

### Step 3: Create ECS Service

1. **Create task definition:**
   ```json
   {
     "family": "calculator-app",
     "networkMode": "awsvpc",
     "requiresCompatibilities": ["FARGATE"],
     "cpu": "256",
     "memory": "512",
     "executionRoleArn": "arn:aws:iam::YOUR_ACCOUNT_ID:role/ecsTaskExecutionRole",
     "containerDefinitions": [
       {
         "name": "calculator-app",
         "image": "YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/calculator-app:latest",
         "portMappings": [
           {
             "containerPort": 80,
             "protocol": "tcp"
           }
         ],
         "logConfiguration": {
           "logDriver": "awslogs",
           "options": {
             "awslogs-group": "/ecs/calculator-app",
             "awslogs-region": "us-east-1",
             "awslogs-stream-prefix": "ecs"
           }
         }
       }
     ]
   }
   ```

2. **Create ECS service:**
   ```bash
   aws ecs create-service \
     --cluster calculator-app-cluster \
     --service-name calculator-app-service \
     --task-definition calculator-app:1 \
     --desired-count 2 \
     --launch-type FARGATE \
     --network-configuration "awsvpcConfiguration={subnets=[subnet-xxx,subnet-yyy],securityGroups=[sg-xxx],assignPublicIp=ENABLED}"
   ```

## CI/CD Pipeline

The project includes `buildspec.yml` which will:
1. Install Flutter
2. Build the web application
3. Create Docker image
4. Push to ECR
5. Update ECS service

## Local Testing

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run app:**
   ```bash
   flutter run -d chrome
   ```

3. **Build for production:**
   ```bash
   flutter build web --release
   ```

4. **Test Docker build:**
   ```bash
   docker build -t calculator-app .
   docker run -p 8080:80 calculator-app
   ```

## Monitoring and Troubleshooting

1. **Check ECS service status:**
   ```bash
   aws ecs describe-services \
     --cluster calculator-app-cluster \
     --services calculator-app-service
   ```

2. **View logs:**
   ```bash
   aws logs describe-log-streams \
     --log-group-name /ecs/calculator-app
   ```

3. **Update service:**
   ```bash
   aws ecs update-service \
     --cluster calculator-app-cluster \
     --service calculator-app-service \
     --force-new-deployment
   ```

## Security Considerations

- ECR repository has image scanning enabled
- Security groups restrict access to necessary ports only
- ECS tasks run with minimal required permissions
- Nginx configured with security headers

## Scaling

- ECS service can be scaled horizontally
- Application Load Balancer distributes traffic
- Fargate handles infrastructure scaling automatically