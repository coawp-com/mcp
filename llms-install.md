# Installing the coawp MCP server

coawp is a hosted MCP server at `https://coawp.com/mcp`. It runs over Streamable HTTP and needs no sign-in, API key, package or local runtime, so there is nothing to download or build.

## Cline

Add this to `cline_mcp_settings.json` (Cline's MCP Servers panel, Configure MCP Servers), keeping any servers already there:

```json
{
  "mcpServers": {
    "coawp": {
      "type": "streamableHttp",
      "url": "https://coawp.com/mcp",
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

Set `type` to `streamableHttp`. Without it Cline uses the older SSE transport, which this server doesn't speak.

In the panel instead: open the Remote Servers tab, name it `coawp`, paste `https://coawp.com/mcp`, choose Streamable HTTP and add it.

## Check it works

The server shows three tools: `search_roles`, `get_roles` and `list_filters`. All three only read, so they are safe to auto-approve. Ask something like "Find software internships in Toronto for summer 2027" and `search_roles` should return a list of roles, each with an apply link.

## Other clients

The [README](README.md) has the steps for Claude, Claude Code, ChatGPT, Codex, Gemini CLI, VS Code, Cursor and Windsurf.
