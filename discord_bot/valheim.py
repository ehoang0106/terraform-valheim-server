import boto3
import json
import time


def load_aws_data():
    with open('../meta_data.json') as file:
        data = json.load(file)
    return data
    

def start_server():
    data=load_aws_data()
    ec2_resource=boto3.resource('ec2', region_name=data['region'])
    instance=ec2_resource.Instance(data['instance_id'])
    
    #start instance
    instance.start()
    print(f'Starting EC2 instance: {instance.id}')
    instance.wait_until_running()
    ip_address=instance.public_ip_address
    print(f'EC2 instance started - State: {instance.state["Name"]}')
    
    #message to discord
    message = f'Valheim server has been started with new IP address: `{ip_address}`.'
    return message

def stop_server():
    data=load_aws_data()
    ec2_resource=boto3.resource('ec2', region_name=data['region'])
    instance=ec2_resource.Instance(data['instance_id'])
    ip_address=instance.public_ip_address
    #stop instance
    instance.stop()
    print(f'Stopping EC2 instance: {instance.id}')
    instance.wait_until_stopped()
    print(f'EC2 instance stopped - State: {instance.state["Name"]}')
    
    #message to discord
    message = f'Valheim server has been stopped. Instance ID: {instance.id}'
    return message

