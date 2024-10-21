import valheim
from dotenv import dotenv_values
from discord.ext import commands
import discord


config = dotenv_values("../.env")

TOKEN=config['DISCORD_TOKEN']
PREFIX=config['PREFIX']

bot = discord.Client()
bot = commands.Bot(command_prefix=PREFIX)


@bot.event
async def on_ready():
    print(f'{bot.user} has connected to Discord!')
    await bot.change_presence(activity=discord.Game(name="Valheim Server"))

@bot.command(name='up')
async def up(ctx):
    
    await ctx.send("🖥️ Starting the server. Please wait!")
    message = valheim.start_server()
    print(message)
    # Send message to discord
    await ctx.send(message)
    
@bot.command(name='down')
async def down(ctx):
    await ctx.send( " 🫸 Stopping the server. Please wait a moment!")
    message = valheim.stop_server()
    print(message)
    #send message to discord
    await ctx.send(message)

@bot.event
async def on_command_error(ctx, error):
    if isinstance(error, commands.CommandNotFound):
        await ctx.send("❌ Invalid command. Please use **`$up`** or **`$down`** to start or stop the server.")
        
        

bot.run(TOKEN)


