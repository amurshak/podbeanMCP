# 🎙️ Podbean MCP Server 🎧

[![smithery badge](https://smithery.ai/badge/@amurshak/podbeanmcp)](https://smithery.ai/server/@amurshak/podbeanmcp)

An MCP server for managing your podcast through the Podbean API.

## 🎉 Overview

This MCP server connects any MCP-compatible AI assistant to the Podbean API. Whether you're using Cline (the IDE MCP Client), Claude Desktop, or any other MCP client, you can now manage your podcasts, episodes, and analytics through natural conversation!

## ✨ Features

### 🔐 Authentication
- Client credentials authentication for managing your own podcasts
- OAuth flow for third-party access (when needed)
- Token management for multiple podcasts - juggle them all!

### 🎙️ Podcast Management
- List all your awesome podcasts in one place
- Get the nitty-gritty details about your shows
- Peek at your stats and analytics (who's listening?)
- Browse podcast categories to find your niche

### 📝 Episode Management
- See all episodes for your podcast at a glance
- Dig into the details of any episode
- Publish new episodes with ease (no more complex forms!)
- Update existing episodes when you need a tweak
- Delete episodes that didn't quite hit the mark

### 📁 File Management (Limited)
- Get authorization for file uploads to Podbean (presigned URLs)
- **Note:** Due to STDIO protocol limitations, this server cannot directly upload files
- The server provides the necessary authorization and file keys, but actual file uploads must be handled externally

### 📊 Analytics
- Check out how many downloads your podcast is getting
- Track your daily listener counts (watching them grow!)
- See how users are interacting with your content

### 🌐 Public Podcast Access
- Access public podcast data through oEmbed
- Get the scoop on any public episode out there

## 🧰 Prerequisites

- Python 3.10 or higher (time to upgrade if you haven't already!)
- A Podbean account with API access (free or paid - they're all welcome)
- Podbean API credentials (Client ID and Secret - your magical keys to the kingdom)

## 🚀 Installation

### Installing via Smithery

To install Podbean Podcast Manager for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@amurshak/podbeanmcp):

```bash
npx -y @smithery/cli install @amurshak/podbeanmcp --client claude
```

1. Grab the code:
   ```bash
   git clone <repository-url>
   cd PodbeanMCP
   ```

2. Set up a virtual environment using the super-speedy `uv` tool:
   ```bash
   uv venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. Install the package and its dependencies:
   ```bash
   # Using uv (faster)
   uv pip install -e .
   ```

   Or if you prefer traditional pip:
   ```bash
   pip install -e .
   ```
   
   This will install all dependencies from the pyproject.toml file, including:
   - mcp[cli] (MCP SDK)
   - httpx (for API requests)
   - python-dotenv (for environment variables)
   - pydantic (for data validation)

4. Create a `.env` file with your secret Podbean powers:
   ```
   PODBEAN_CLIENT_ID=your_client_id
   PODBEAN_CLIENT_SECRET=your_client_secret
   ```

## 📝 Configuring in cline_mcp_settings.json

The recommended way to use this MCP server is to configure it directly in your cline_mcp_settings.json file. This allows the Cline IDE MCP Client to automatically start the server when needed.

1. Locate your cline_mcp_settings.json file. This file is used by Cline IDE to configure MCP servers. Refer to the Cline IDE documentation for the exact location of this file on your system.

2. Add the Podbean MCP server configuration to the "mcpServers" object:

```json
{
  "mcpServers": {
    "Podbean MCP": {
      "command": "uv",
      "args": [
        "run",
        "--with",
        "mcp[cli]",
        "mcp",
        "run",
        "/full/path/to/PodbeanMCP/server.py"
      ],
      "env": {
        "PODBEAN_CLIENT_ID": "your_client_id",
        "PODBEAN_CLIENT_SECRET": "your_client_secret"
      }
    }
  }
}
```

3. Customize the configuration:
   - Replace `/full/path/to/PodbeanMCP/server.py` with the absolute path to your server.py file
   - Replace `your_client_id` and `your_client_secret` with your Podbean API credentials from your .env file
   - If you're not using `uv`, adjust the command and args accordingly

4. Save the file and restart Cline IDE

> **Important Note**: You do not need to manually run the server with `python server.py` when using this configuration. Cline IDE will automatically start the server when needed and Claude (the AI) will be able to access it.

### Example with Multiple Servers

If you already have other MCP servers in your config, simply add the Podbean MCP server as a new entry:

```json
{
  "mcpServers": {
    "Some Other MCP": {
      "command": "...",
      "args": [
        "..."
      ]
    },
    "Podbean MCP": {
      "command": "uv",
      "args": [
        "run",
        "--with",
        "mcp[cli]",
        "mcp",
        "run",
        "/full/path/to/PodbeanMCP/server.py"
      ],
      "env": {
        "PODBEAN_CLIENT_ID": "your_client_id",
        "PODBEAN_CLIENT_SECRET": "your_client_secret"
      }
    }
  }
}
```

## 🧪 Testing Your Installation

After configuring the MCP server in your cline_mcp_settings.json file, you can test if it's working properly by asking Claude to use one of the Podbean MCP tools:

1. **Authenticate with Podbean**:
   ```
   Can you authenticate with my Podbean account using the Podbean MCP server?
   ```

2. **List your podcasts**:
   ```
   Can you list my podcasts using the Podbean MCP server?
   ```

3. **Get episodes for a specific podcast**:
   ```
   Can you get the episodes for my podcast with ID "your_podcast_id" using the Podbean MCP server?
   ```

If Claude successfully executes these commands and returns the expected results, your Podbean MCP server is working correctly!

## 🔧 Available Tools

### 🔑 Authentication Tools
- `authenticate_with_podbean()`: Get your VIP backstage pass to Podbean
- `get_podcast_tokens()`: Collect tokens for all your podcasts like Pokémon
- `get_podcast_token(podcast_id)`: Grab a token for just that special podcast

### 🎙️ Podcast Tools
- `list_podcasts_tool()`: See your podcast empire at a glance
- `get_podcast_info()`: Get the 411 on your podcast
- `get_podcast_stats(podcast_id, start_date, end_date, period, episode_id)`: Numbers, charts, and bragging rights!
- `get_daily_listeners(podcast_id, month)`: Track your growing audience day by day
- `browse_podcast_categories()`: Explore the podcast universe by category

### 🎧 Episode Tools
- `get_podcast_episodes_tool(podcast_id)`: Round up all episodes from your show
- `get_episode_details_tool(episode_id)`: Zoom in on a specific episode
- `publish_episode(podcast_id, title, content, ...)`: Release your voice to the world!
- `update_episode(episode_id, podcast_id, ...)`: Tweak that episode to perfection
- `delete_episode(episode_id, podcast_id, delete_media)`: Oops! That one needs to go...

### 💾 File Authorization Tools (Limited)
- `authorize_file_upload(podcast_id, filename, filesize, content_type)`: Get permission to upload files
- `upload_file_to_podbean(presigned_url, file_path, content_type, file_key)`: **Note: This is a placeholder function that simulates file uploads but doesn't actually transfer files due to STDIO protocol limitations**

### 🌐 Public Access Tools
- `get_oembed_data(url)`: Get embeddable goodies for any Podbean URL
- `get_public_episode_info(episode_url)`: Snoop on any public episode (legally, of course!)

### 🔗 OAuth Tools (for Third-Party Access)
- `generate_oauth_url(redirect_uri, scope, state)`: Create a magic login link
- `exchange_oauth_code(code, redirect_uri)`: Trade your code for a shiny token
- `refresh_oauth_token(refresh_token)`: Renew your expired token - no waiting in line!

## 📚 Available Resources

- `podbean://auth`: Your authentication treasure chest
- `podbean://podcast/{podcast_id}`: Episode collection for your podcast
- `podbean://episode/{episode_id}`: All the juicy details about an episode
- `podbean://upload/authorize`: Your upload permission slip (but not actual uploads)
- `podbean://categories`: The podcast category encyclopedia
- `podbean://public/oembed`: Embed-friendly data for any Podbean URL
- `podbean://oauth/authorize`: Your OAuth permission gateway

## 💬 Available Prompts

- `podcast_summary(podcast_id)`: "Hey AI, can you summarize my podcast?"
- `episode_transcript(episode_id)`: "Turn my ramblings into readable text, please!"

## 💬 Example Usage with Any MCP Client

Here are some fun ways to chat with your AI assistant using this MCP server:

1. **Get the VIP pass**:
   ```
   Hey, can you authenticate with my Podbean account and show me my podcast collection?
   ```

2. **Round up the episodes**:
   ```
   I'm feeling nostalgic! Show me all the episodes from my "Cooking with Code" podcast.
   ```

3. **Share your brilliance with the world**:
   ```
   I'm ready to drop a new episode! It's called "AI in Podcasting" and it's all about how AI is making podcasting easier and more fun. Can you help me publish it?
   ```

4. **Check if anyone's listening** 👂:
   ```
   How's my podcast doing? Can you show me the download stats from last week?
   ```

## 🛠️ Error Handling

We've got your back when things go sideways! This server comes with super-friendly error handling:

- Authentication hiccups? We'll guide you through fixing them 🔧
- API giving you trouble? We'll tell you exactly what went wrong 🚨
- Tried something that doesn't compute? We'll let you know before it breaks 🤓
- Detailed error messages that actually make sense to humans! 😮‍💨

## 🚧 Limitations

- **File Uploads**: Due to STDIO protocol limitations, this server cannot directly upload files to Podbean. It can obtain the necessary authorization (presigned URLs) and file keys, but the actual file transfer must be handled by external tools or processes.
- Some fancy features might need a paid Podbean subscription 💳
- Podbean has rate limits, so don't go too wild with the requests 🚀
- We can't make your podcast content go viral (that's still on you!) 🌟

## 👩‍💻 Contributing

Got ideas to make this even better? We'd love your help! Fork, code, and send us a Pull Request. Let's make podcast management even more awesome together! 🤝

## 📃 License

[Insert your favorite license here - keep it open source if you can!]

## 👏 Acknowledgments

- The amazing folks behind the Podbean API docs 📖
- The wizards who created the MCP SDK 🧙‍♂️
- You, for using this tool to make awesome podcasts! 🎉
