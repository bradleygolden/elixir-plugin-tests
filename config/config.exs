import Config

config :elixir_plugin_tests,
  ash_domains: [ElixirPluginTests.Domain],
  ecto_repos: [ElixirPluginTests.Repo]

config :elixir_plugin_tests, ElixirPluginTests.Repo,
  database: "elixir_plugin_tests_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
