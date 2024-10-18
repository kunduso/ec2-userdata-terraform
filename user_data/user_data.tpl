#!/bin/bash
# Update the instance
yum update -y

# Install the CloudWatch Agent
yum install -y amazon-cloudwatch-agent
echo "Installed Amazon CloudWatch Agent."

# Creates token to authenticate and retrieve instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

# Set the AWS region using the token
AWS_REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/region)
export AWS_DEFAULT_REGION=$AWS_REGION
echo "Setting AWS Region to: $AWS_DEFAULT_REGION"

# Fetch CloudWatch agent configuration from SSM Parameter Store
CONFIG=$(aws ssm get-parameter --name "${Parameter_Name}" --query "Parameter.Value" --output text)
echo "Fetched CloudWatch agent configuration: $CONFIG"
# Save the configuration to a file
echo $CONFIG > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Start the CloudWatch agent with the new configuration
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Ensure the CloudWatch agent starts on system boot
systemctl enable amazon-cloudwatch-agent