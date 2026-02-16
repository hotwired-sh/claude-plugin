# [2.3.0](https://github.com/hotwired-sh/claude-plugin/compare/v2.2.1...v2.3.0) (2026-02-16)


### Bug Fixes

* **pair:** correct CLI syntax and simplify flow ([c777293](https://github.com/hotwired-sh/claude-plugin/commit/c77729341041275f0fe2964ee6dd933ef67d4549))


### Features

* add `hotwired protocol` to CLI commands, improve compaction recovery ([6d74cbe](https://github.com/hotwired-sh/claude-plugin/commit/6d74cbeb6b80ba810a857ca56f749c76992c20e7))

## [2.2.1](https://github.com/hotwired-sh/claude-plugin/compare/v2.2.0...v2.2.1) (2026-02-15)


### Bug Fixes

* **hotwire:** smarter run resumption logic ([b92394f](https://github.com/hotwired-sh/claude-plugin/commit/b92394f58cf58777ce3de212906c699b9d949406))

# [2.2.0](https://github.com/hotwired-sh/claude-plugin/compare/v2.1.0...v2.2.0) (2026-02-15)


### Features

* remove MCP server dependency ([33570af](https://github.com/hotwired-sh/claude-plugin/commit/33570af2e5ca0ffce9bdc4cf71cc968069579713))

# [2.1.0](https://github.com/hotwired-sh/claude-plugin/compare/v2.0.0...v2.1.0) (2026-02-15)


### Features

* update /hotwire and /pair commands to use CLI ([c7aa569](https://github.com/hotwired-sh/claude-plugin/commit/c7aa569))

Switch from MCP tool calls to hotwired CLI commands:
- /hotwire now uses `hotwired hotwire` CLI command
- /pair now uses `hotwired pair` CLI command
- Prerequisite check uses `hotwired status` instead of MCP ping

# [2.0.0](https://github.com/hotwired-sh/claude-plugin/compare/v1.0.2...v2.0.0) (2026-02-15)


* feat!: switch from MCP tools to CLI commands for agent communication ([4ac5aa5](https://github.com/hotwired-sh/claude-plugin/commit/4ac5aa57c54de7d41d2b836f39376388b0fffa9a))


### BREAKING CHANGES

* Agent communication now uses `hotwired` CLI commands
instead of MCP tools. Requires playbooks v2.0.0+.

- `handoff` → `hotwired send --to <agent>`
- `send_message` → `hotwired send --to human`
- `report_impediment` → `hotwired impediment`
- `task_complete` → `hotwired complete`
- `get_run_status` → `hotwired status`

MCP tools are still used for workflow setup (hotwire, pair, ping).

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>

## [1.0.2](https://github.com/hotwired-sh/claude-plugin/compare/v1.0.1...v1.0.2) (2026-02-05)


### Bug Fixes

* **hooks:** ensure hooks are called on session start/end ([2fa81f1](https://github.com/hotwired-sh/claude-plugin/commit/2fa81f18b2b8e5e3446b9dbf585488d47e27566b))

## [1.0.1](https://github.com/hotwired-sh/claude-plugin/compare/v1.0.0...v1.0.1) (2026-02-05)


### Bug Fixes

* **hooks:** correct hooks.json structure with proper nesting ([21ae816](https://github.com/hotwired-sh/claude-plugin/commit/21ae816b0a348ae6860249c83f75a0eaeeb221d9))

# 1.0.0 (2026-02-04)


### Bug Fixes

* simplify marketplace name to hotwired-sh ([9950224](https://github.com/hotwired-sh/claude-plugin/commit/9950224402903f939d50f43e87c958b0d21c2666))
* update scripts for dev mode and fix hook format ([bc50259](https://github.com/hotwired-sh/claude-plugin/commit/bc5025972c179141bfe2daa31e83164e70747d02))
* updates repo and scripts ([a395c1f](https://github.com/hotwired-sh/claude-plugin/commit/a395c1f19d396cfab0e080235e06cd057b59d161))
* use subcommand syntax for register/deregister ([80315c8](https://github.com/hotwired-sh/claude-plugin/commit/80315c85246fa57132a7940dcb998ed452b292f7))


### Features

* add /hotwire and /pair commands for terminal-first workflow ([710f17a](https://github.com/hotwired-sh/claude-plugin/commit/710f17a40cfef844e95d455766cfa7f306d8f6dd))
* add semantic versioning CI workflow ([ebf8eb3](https://github.com/hotwired-sh/claude-plugin/commit/ebf8eb38251b031c07a4bc51af690aa806d2f400))
* add versioning to plugin (v1.0.0) ([f8ee76f](https://github.com/hotwired-sh/claude-plugin/commit/f8ee76f6d209aa6807b3a3b6b43ef02c785df4b8))
