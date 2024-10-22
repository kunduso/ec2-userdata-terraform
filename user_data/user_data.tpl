#!/bin/bash
# Update the instance
yum update -y
if [ $? -eq 0 ]; then
    echo "Updated the instance successfully."
else
    echo "Failed to update the instance."
    exit 1
fi

# Install the CloudWatch Agent
yum install -y amazon-cloudwatch-agent
if [ $? -eq 0 ]; then
    echo "Installed Amazon CloudWatch Agent."
else
    echo "Failed to install Amazon CloudWatch Agent."
    exit 1
fi

# Creates token to authenticate and retrieve instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
if [ $? -eq 0 ]; then
    echo "Created token for instance metadata."
else
    echo "Failed to create token."
    exit 1
fi

# Set the AWS region using the token
AWS_REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/region)
if [ $? -eq 0 ]; then
    export AWS_DEFAULT_REGION=$AWS_REGION
    echo "Setting AWS Region to: $AWS_DEFAULT_REGION"
else
    echo "Failed to fetch AWS region."
    exit 1
fi

# Fetch CloudWatch agent configuration from SSM Parameter Store
CONFIG=$(aws ssm get-parameter --name "${Parameter_Name}" --with-decryption --query "Parameter.Value" --output text)
if [ $? -eq 0 ]; then
    echo "Fetched CloudWatch agent configuration."
else
    echo "Failed to fetch CloudWatch agent configuration."
    exit 1
fi

# Save the configuration to a file
echo $CONFIG > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
if [ $? -eq 0 ]; then
    echo "Saved CloudWatch agent configuration to file."
else
    echo "Failed to save CloudWatch agent configuration."
    exit 1
fi

# Start the CloudWatch agent with the new configuration
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
if [ $? -eq 0 ]; then
    echo "Started CloudWatch agent with new configuration."
else
    echo "Failed to start CloudWatch agent."
    exit 1
fi

# Ensure the CloudWatch agent starts on system boot
systemctl enable amazon-cloudwatch-agent
if [ $? -eq 0 ]; then
    echo "Configured CloudWatch agent to start on boot."
else
    echo "Failed to enable CloudWatch agent on boot."
    exit 1
fi
