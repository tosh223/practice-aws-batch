# practice-aws-batch

This is sample code of AWS Batch on AWS Fargate, calling from AWS Step Functions.

AWS Step Functions state machine is set to run periodically from Amazon EventBridge.
Demonstrates how to set environment variables in Amazon ECS container and get sensitive data from AWS Secrets Manager. Container images and sensitive data are acquired by private connection with AWS PrivateLink, without exposing traffic to the public internet.
