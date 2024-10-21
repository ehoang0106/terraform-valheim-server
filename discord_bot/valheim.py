import boto3
import json


def load_aws_data():
    #load region and instance_id from meta_data.json
    with open('../meta_data.json') as file:
        data = json.load(file)
    return data
    

def start_server():
    data=load_aws_data() #import data
    ec2_resource=boto3.resource('ec2', region_name=data['region']) 
    instance=ec2_resource.Instance(data['instance_id'])
    
    #start instance
    instance.start()
    print(f'Starting EC2 instance: {instance.id}')
    instance.wait_until_running()
    #wait until instance is running and get the public ip address
    ip_address=instance.public_ip_address #put this before the wait_until_running() method will return None
    
    #message to discord
    message = f'👏 Yay! Valheim server has been started. \nHere is your new IP Address:\n **`{ip_address}`**'
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
    message = f'🛑 Valheim server [**`{ip_address}`**] has been stopped ❌'
    return message

