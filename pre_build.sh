#!/bin/bash
set -e

echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region "$AWS_DEFAULT_REGION" | docker login --username AWS --password-stdin "$ECR_REPOSITORY_URI"

export REPOSITORY_URI="$ECR_REPOSITORY_URI"
export IMAGE_TAG=$(echo "$CODEBUILD_RESOLVED_SOURCE_VERSION" | cut -c 1-7)

echo "EKS_CLUSTER_NAME=$EKS_CLUSTER_NAME"
echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"

aws eks list-clusters --region "$AWS_DEFAULT_REGION"
aws sts get-caller-identity

echo "Configuring kubeconfig..."
aws eks update-kubeconfig --name "$EKS_CLUSTER_NAME" --region "$AWS_DEFAULT_REGION"
