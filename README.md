# Elixir Plugin Tests

Integration tests for the [Claude Code elixir plugin](https://github.com/bradleygolden/claude) hooks.

## Purpose

This project is a real Elixir/Mix project designed to test both:
- **Post-edit hooks** (PostToolUse) - triggered when Claude edits files
- **Pre-commit hooks** (PreToolUse) - triggered when Claude attempts git commits

The main `claude` repo cannot test pre-commit hooks because it's not a Mix project.

## Setup

1. Clone this repo
2. Install dependencies: `mix deps.get`
3. Install the elixir plugin in Claude Code:
   ```
   /plugin marketplace add github:bradleygolden/claude
   /plugin install elixir@elixir
   ```

## Running Tests

Use the `/run-tests` command to walk through all 14 test scenarios:

```
/run-tests
```

## Test Scenarios

### Post-Edit (5 tests)
1. Format auto-fix
2. Compile error detection
3. Credo warnings
4. Ash codegen detection
5. Sobelow security findings

### Pre-Commit (9 tests)
6. Format check blocking
7. Compile error blocking
8. Credo strict blocking
9. Unused deps blocking
10. Ash codegen blocking
11. Dialyzer blocking
12. ExUnit test failure blocking
13. Mix audit blocking
14. Sobelow blocking

## Dependencies

- Ash Framework + AshPostgres
- Credo (code quality)
- Dialyxir (type checking)
- ExDoc (documentation)
- Sobelow (security analysis)
- Mix Audit (dependency security)
