## Create .env to contain bot token
This is for your bot on Discord
```shell
    TOKEN = <YOUR_BOT_DISCORD_TOKEN>
    PREFIX= <YOUR_PREFIX>
```

## Create a meta_data.json file
You also need to install `AWS CLI` and give the CLI the access by configure in `aws configure`.

After that, create a meta_data.json in the root folder
```json
{
    "region": "<your aws ec2 instance region>",
    "instance_id": "<your aws vrising instance id>"
}
```
