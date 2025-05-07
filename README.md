# Podbean MCP Server

A Model-Content-Provider (MCP) server for integrating Podbean podcast management with Claude Desktop.

## Overview

This MCP server allows Claude to interact with the Podbean API, enabling you to manage your podcasts, episodes, and access podcast analytics directly through Claude. It provides a bridge between Claude's capabilities and your Podbean account, making podcast management more efficient through natural language interactions.

## Features

### Authentication
- Client credentials authentication for managing your own podcasts
- OAuth flow for third-party access (when needed)
- Token management for multiple podcasts

### Podcast Management
- List all podcasts in your Podbean account
- Get detailed podcast information
- Access podcast statistics and analytics
- Browse podcast categories

### Episode Management
- List episodes for a specific podcast
- Get detailed episode information
- Publish new episodes
- Update existing episodes
- Delete episodes

### File Management
- Authorize file uploads to Podbean
- Upload audio files and images
- Use uploaded files in episode creation/updates

### Analytics
- Access download statistics for podcasts and episodes
- Get daily listener data
- View user interaction statistics

### Public Podcast Access
- Access public podcast data through oEmbed
- Get information about any public episode

## Prerequisites

- Python 3.10 or higher
- A Podbean account with API access
- Podbean API credentials (Client ID and Client Secret)

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd PodbeanMCP
   ```

2. Set up a virtual environment using `uv`:
   ```bash
   uv venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   uv pip install -r requirements.txt
   ```

4. Create a `.env` file with your Podbean API credentials:
   ```
   PODBEAN_CLIENT_ID=your_client_id
   PODBEAN_CLIENT_SECRET=your_client_secret
   ```

## Running the Server

Start the MCP server:
```bash
python server.py
```

The server will start on the default port (specified in the MCP SDK configuration).

## Connecting to Claude Desktop

1. Open Claude Desktop
2. Go to Settings > MCP Servers
3. Add a new MCP server with the URL where your server is running (e.g., `http://localhost:8000`)
4. Claude will now have access to all the Podbean tools and resources

## Available Tools

### Authentication Tools
- `authenticate_with_podbean()`: Get authentication information
- `get_podcast_tokens()`: Get access tokens for all podcasts
- `get_podcast_token(podcast_id)`: Get access token for a specific podcast

### Podcast Tools
- `list_podcasts_tool()`: List all podcasts in your account
- `get_podcast_info()`: Get information about your podcast
- `get_podcast_stats(podcast_id, start_date, end_date, period, episode_id)`: Get download statistics
- `get_daily_listeners(podcast_id, month)`: Get daily listener data
- `browse_podcast_categories()`: Browse available podcast categories

### Episode Tools
- `get_podcast_episodes_tool(podcast_id)`: Get episodes for a specific podcast
- `get_episode_details_tool(episode_id)`: Get detailed information about an episode
- `publish_episode(podcast_id, title, content, ...)`: Publish a new episode
- `update_episode(episode_id, podcast_id, ...)`: Update an existing episode
- `delete_episode(episode_id, podcast_id, delete_media)`: Delete an episode

### File Upload Tools
- `authorize_file_upload(podcast_id, filename, filesize, content_type)`: Get authorization for file upload
- `upload_file_to_podbean(presigned_url, file_path, content_type, file_key)`: Upload a file

### Public Access Tools
- `get_oembed_data(url)`: Get embeddable content for any Podbean URL
- `get_public_episode_info(episode_url)`: Get information about a public episode

### OAuth Tools (for Third-Party Access)
- `generate_oauth_url(redirect_uri, scope, state)`: Generate OAuth authorization URL
- `exchange_oauth_code(code, redirect_uri)`: Exchange authorization code for token
- `refresh_oauth_token(refresh_token)`: Refresh an OAuth access token

## Available Resources

- `podbean://auth`: Authentication information
- `podbean://podcast/{podcast_id}`: Episodes for a specific podcast
- `podbean://episode/{episode_id}`: Details for a specific episode
- `podbean://upload/authorize`: File upload authorization
- `podbean://categories`: Podcast categories
- `podbean://public/oembed`: oEmbed information for any Podbean URL
- `podbean://oauth/authorize`: OAuth authorization URL

## Available Prompts

- `podcast_summary(podcast_id)`: Generate a prompt to summarize a podcast
- `episode_transcript(episode_id)`: Generate a prompt to create a transcript for an episode

## Example Usage with Claude

Here are some examples of how you can interact with Claude using this MCP server:

1. **Authenticate with Podbean**:
   ```
   Claude, please authenticate with my Podbean account and show me my podcasts.
   ```

2. **Get podcast episodes**:
   ```
   Show me the latest episodes from my podcast with ID "abc123".
   ```

3. **Publish a new episode**:
   ```
   I want to publish a new episode titled "AI in Podcasting" with the following description: "In this episode, we discuss how AI is transforming podcast creation and distribution."
   ```

4. **Get podcast statistics**:
   ```
   Show me the download statistics for my podcast from May 1st to May 7th, 2025.
   ```

## Error Handling

The server includes comprehensive error handling to provide clear messages when issues occur:

- Authentication errors with troubleshooting guidance
- API request failures with specific error messages
- Input validation to prevent invalid requests
- Detailed error responses for debugging

## Limitations

- File upload functionality requires a separate process to actually upload files to Podbean
- Some features may require specific Podbean subscription plans
- Rate limits apply according to Podbean's API policies

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[Specify your license here]

## Acknowledgments

- Podbean API documentation
- MCP SDK developers
