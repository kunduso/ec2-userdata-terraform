#!/bin/bash
yum update -y
yum install python-pip -y
yum install python3 -y
pip3 install boto3
pip3 install botocore
echo "The region value is ${Region}"
AWS_REGION=${Region}
local_secret_string=${secret_string}
cat <<EOF >> /var/read_secret.py
from botocore.exceptions import ClientError
import logging
import boto3

def main():
    session = boto3.Session(region_name='$AWS_REGION')
    secret_value = get_secret(session)
    print("The value of the $local_secret_string is "+secret_value)

def get_secret(session):
    secret_client = session.client('secretsmanager')
    try:
        get_secret_value_response = secret_client.get_secret_value(
            SecretId='$local_secret_string'
        )
    except ClientError as e:
        raise e
    return get_secret_value_response['SecretString']

main()
EOF