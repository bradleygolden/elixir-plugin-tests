Run integration tests for the elixir plugin hooks.

## Test Scenarios

### Post-Edit Tests (5)

1. **Format**: Edit `lib/elixir_plugin_tests.ex` with bad formatting (`def foo,do: :bar`)
   - Expected: File auto-formats (comma gets space, visible in system-reminder showing file was modified)

2. **Compile Error**: Edit to introduce syntax error (`def broken(`)
   - Expected: `[COMPILE ERROR]` in system-reminder

3. **Credo**: Add `IO.inspect(:debug)` to a function
   - Expected: `[CREDO]` warning about IO.inspect

4. **Ash Codegen**: Add attribute to `lib/elixir_plugin_tests/example_resource.ex`
   - Expected: `[ASH CODEGEN]` pending code generation

5. **Sobelow**: Add SQL injection pattern with proper alias to pass Credo:
   ```elixir
   alias Ecto.Adapters.SQL
   def get_user(repo, id), do: SQL.query(repo, "SELECT * FROM users WHERE id = #{id}")
   ```
   - Expected: `[SOBELOW SECURITY]` in system-reminder

### Pre-Commit Tests (10)

6. **Format Block**: Make code unformatted via bash, stage, commit
   - Expected: Commit blocked with `[FORMAT]`

7. **Compile Block**: Introduce syntax error, stage, commit
   - Expected: Commit blocked with `[COMPILE]`

8. **Credo Block**: Add IO.inspect, stage, commit
   - Expected: Commit blocked with `[CREDO]`

9. **Unused Deps Block**: Create orphaned dependency in mix.lock
   - Steps: Add dep (e.g., `{:puck, "~> 0.1"}`), run `mix deps.get`, then REMOVE dep from mix.exs but keep mix.lock unchanged
   - Stage both mix.exs and mix.lock, then commit
   - Expected: Commit blocked with `[DEPS]`

10. **Ash Codegen Block**: Add attribute without running codegen, stage, commit
    - Expected: Commit blocked with `[ASH CODEGEN]`

11. **Dialyzer Block**: Introduce type error, stage, commit
    - Expected: Commit blocked with `[DIALYZER]`

12. **ExUnit Block**: Create failing test, stage, commit
    - Expected: Commit blocked with `[TESTS]`

13. **Mix Audit Block**: (requires vulnerable dep in mix.lock)
    - Expected: Commit blocked with `[SECURITY AUDIT]`
    - Note: Skip if no vulnerable deps available to test

14. **Sobelow Block**: Add high-confidence security issue to config, stage, commit
    - Add to config/config.exs: `config :elixir_plugin_tests, secret_token: "hardcoded_secret"`
    - Expected: Commit blocked with `[SOBELOW]`

15. **Precommit Alias**: Test that `mix precommit` alias takes precedence
    - Add to mix.exs project: `aliases: [precommit: ["format --check-formatted", "compile --warnings-as-errors"]]`
    - Introduce a Credo issue (IO.inspect), stage, commit
    - Expected: Commit succeeds (Credo not in the alias, so not checked)
    - Then add a format issue and verify it blocks
    - Expected: Commit blocked with "Precommit failed"

## Execution

Use TodoWrite to track progress through scenarios:
1. Make the change (use Bash for pre-commit tests to avoid auto-format)
2. Observe hook response (system-reminder for post-edit, denial for pre-commit)
3. Restore file to original state: `git checkout -- <file>`
4. Report pass/fail

## Results Format

| # | Test | Type | Status | Evidence |
|---|------|------|--------|----------|
| 1 | Format | PostToolUse | PASS/FAIL | ... |
| ... | ... | ... | ... | ... |

## Notes

- Pre-commit tests require using Bash to write unformatted code (Edit auto-formats)
- Stage files with `git add` before attempting commit
- The plugin must be installed for hooks to work
- Unused deps test requires creating an orphan in mix.lock (add dep, install, remove from mix.exs)
- Sobelow tests require high or medium confidence findings (low confidence doesn't block)
- Sobelow PostToolUse requires aliasing `Ecto.Adapters.SQL` to avoid Credo nested module warnings
