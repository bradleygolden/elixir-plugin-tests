defmodule ElixirPluginTests.Domain do
  @moduledoc "Domain for testing Ash hooks"

  use Ash.Domain, validate_config_inclusion?: false

  resources do
    resource(ElixirPluginTests.ExampleResource)
  end
end
