# Automating Valheim Server Hosting on AWS with Terraform and GitHub Actions

## Create discord bot

You can visit here: [Discord application](https://discord.com/developers/docs/intro)


### Create .env to store the bot token

After your bot is ready to spin up, copy the token and put it in the .env file below.
You can use the prefix of the bot like `!`, `$`, `+` 

```py
    TOKEN = <YOUR_BOT_DISCORD_TOKEN>
    PREFIX= <YOUR_PREFIX>
```
Run `bot.py` to run the bot.

### Create a meta_data.json file
You also need to install the [`AWS CLI`](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and give the CLI access to the necessary permissions to start and stop instances by configuring it with "aws configure".

After that, create a `meta_data.json` in the root folder
```json
{
    "region": "<your aws ec2 instance region>",
    "instance_id": "<your aws valheim instance id>"
}
```

### Run docker image

Since terraform does not support to run the docker container, you need to manually install docker image in the server from [mbround18/valheim](https://hub.docker.com/r/mbround18/valheim)

Here is the basic example of a docker compose. Please visit the link above for more details

```
version: "3"
services:
  valheim:
    image: mbround18/valheim:latest
    ports:
      - 2456:2456/udp
      - 2457:2457/udp
      - 2458:2458/udp
    environment:
      PORT: 2456
      NAME: "Created With Valheim Docker"
      WORLD: "Dedicated"
      PASSWORD: "Banana Phone"
      TZ: "America/Chicago"
      PUBLIC: 1
    volumes:
      - ./valheim/saves:/home/steam/.config/unity3d/IronGate/Valheim
      - ./valheim/server:/home/steam/valheim

```
