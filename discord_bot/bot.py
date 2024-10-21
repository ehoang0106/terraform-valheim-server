import valheim
from dotenv import dotenv_values
from discord.ext import commands
import discord


config = dotenv_values("../.env")

TOKEN=config['DISCORD_TOKEN']
PREFIX=config['PREFIX']

bot = discord.Client()

### PREFIX ###
bot = commands.Bot(command_prefix=PREFIX)

# succesfully message


@bot.event
async def on_ready():
    print(f'{bot.user} has connected to Discord!')

### CALL ###

@bot.command(name='up')
async def up(ctx):
    
    await ctx.send("Your request has been received. Please allow me a moment!")
    message = valheim.start_server()
    print(message)
    # Send message to discord
    await ctx.send(message)
    


@bot.command(name='down')
async def down(ctx):
    await ctx.send("You request has been received. Please allow me a moment!")
    message = valheim.stop_server()
    print(message)
    #send message to discord
    await ctx.send(message)
    
bot.run(TOKEN)


