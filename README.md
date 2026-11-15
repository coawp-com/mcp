# coawp MCP server

Search open internships, co-ops and student jobs from your AI assistant. The roles come from employers' own job boards and are the same ones listed on [coawp.com](https://coawp.com), refreshed every 2 hours.

```
https://coawp.com/mcp
```

A remote MCP server over streamable HTTP, with no sign-in or key. It's in the [official MCP Registry](https://registry.modelcontextprotocol.io/v0.1/servers?search=com.coawp) as `com.coawp/internships`.

## Add it

**Claude** (claude.ai and the desktop app): open [Settings, Connectors](https://claude.ai/settings/connectors), choose Add custom connector, and paste the address.

**Claude Code**

```sh
claude mcp add --transport http coawp https://coawp.com/mcp
```

**ChatGPT**: in [Settings, Apps and Connectors](https://chatgpt.com/#settings/Connectors), turn on Developer mode under Advanced, then choose Create, paste the address and pick No authentication.

**Codex**

```sh
codex mcp add coawp --url https://coawp.com/mcp
```

**Gemini CLI**

```sh
gemini mcp add --transport http coawp https://coawp.com/mcp
```

**VS Code** (Copilot agent mode)

```sh
code --add-mcp '{"name":"coawp","type":"http","url":"https://coawp.com/mcp"}'
```

**Cline**: in the MCP Servers panel, open Remote Servers, paste the address and choose Streamable HTTP. [llms-install.md](llms-install.md) has the config file version.

**Cursor, Windsurf and other apps**: add it to the app's MCP config file.

```json
{ "mcpServers": { "coawp": { "url": "https://coawp.com/mcp" } } }
```

## Tools

All three only read.

| Tool | What it does |
| --- | --- |
| `search_roles` | Finds roles by keyword, role type, field, category, major, skills, required languages, work term, term length, work mode, company, place and posting date. A place can be a town with a radius, a province or state, a country, or remote. Returns a page of short summaries, each with its apply link. |
| `get_roles` | Reads up to 5 roles in full: every skill and major, and the employer's posting text, to check a role against a resume. |
| `list_filters` | Lists the values the filters take, with how many open roles have each, and looks up companies, skills and places by name. |

Two prompts start common searches: `find_roles` (from what someone studies and wants) and `match_resume` (from a pasted resume).

## Things to ask

- Find software internships in Toronto for summer 2027 that use Python.
- I'm a third year mechanical engineering student. Which co-ops in Ontario fit me?
- Show me remote data internships posted this week.
- Here's my resume. Which open roles fit it, and what am I missing for each?

## Limits

- Up to 120 requests a minute from one address. Past that, a tool call answers that coawp is busy for a minute.
- Speaks MCP 2024-11-05 through 2026-07-28.

## What's recorded

coawp counts how the server is used with its own analytics (Wool): which tool was called, the search words, place and skills it was given (cut to 100 characters), how many roles came back, the assistant app's name and the request's country. The request's IP address and user agent are used to count distinct visitors. There are no accounts. Cloudflare, which runs the server, keeps short-lived request logs.

## Help

Open an [issue](https://github.com/coawp-com/mcp/issues) for a bug, a wrong listing or a question.

## Publishing

This repo holds the server's registry entry, `server.json`. The server itself runs on coawp.com. To publish a new version, set `version` in `server.json` to the server's version, then push a matching tag (for example `v2.0.1`). The Registry workflow checks the entry and publishes it, signing in as coawp.com with the key in the domain's DNS record.
