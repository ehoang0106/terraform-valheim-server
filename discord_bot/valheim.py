import boto3
import json

def load_aws_data():
    with open('meta_data.json') as file:
        data = json.load(file)
    return data
    

def stop_server():
    data=load_aws_data()
    ec2_resource=boto3.resource('ec2', region_name=data['region'])
    instance=ec2_resource.Instance(data['instance_id'])
    ip_address=instance.public_ip_address
    
    #stop instance
    instance.stop()
    print(f'Stopping EC2 instance: {instance.id}')
    instance.wait_until_stopped()
    print(f'EC2 instance stopped: {instance.id}')
    
    #message to discord
    message = f'Valheim server has been stopped. IP address: {ip_address}. Instance ID: {instance.id}'
    return message

def start_server():
    data=load_aws_data()
    ec2_resource=boto3.resource('ec2', region_name=data['region'])
    instance=ec2_resource.Instance(data['instance_id'])
    ip_address=instance.public_ip_address
    
    #start instance
    instance.start()
    print(f'Starting EC2 instance: {instance.id}')
    instance.wait_until_running()
    print(f'EC2 instance started: {instance.id}')
    
    #message to discord
    message = f'Valheim server has been started with newIP address: `{ip_address}`.'
    return message



