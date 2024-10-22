## Create .env to store the bot token

```py
    TOKEN = <YOUR_BOT_DISCORD_TOKEN>
    PREFIX= <YOUR_PREFIX>
```

## Create a meta_data.json file
You also need to install the [`AWS CLI`](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and give the CLI access to the necessary permissions to start and stop instances by configuring it with "aws configure".

After that, create a `meta_data.json` in the root folder
```json
{
    "region": "<your aws ec2 instance region>",
    "instance_id": "<your aws valheim instance id>"
}
```
