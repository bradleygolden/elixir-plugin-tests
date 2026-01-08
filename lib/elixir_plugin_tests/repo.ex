defmodule ElixirPluginTests.Repo do
  @moduledoc "Repo for testing Ash hooks"

  use AshPostgres.Repo, otp_app: :elixir_plugin_tests, warn_on_missing_ash_functions?: false

  def min_pg_version, do: %Version{major: 14, minor: 0, patch: 0}
end
