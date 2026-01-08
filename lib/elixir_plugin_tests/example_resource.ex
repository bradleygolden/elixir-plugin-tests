defmodule ElixirPluginTests.ExampleResource do
  @moduledoc "Example Ash resource for testing hooks"

  use Ash.Resource,
    domain: ElixirPluginTests.Domain,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("examples")
    repo(ElixirPluginTests.Repo)
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:name, :string, allow_nil?: false, public?: true)
  end

  actions do
    defaults([:read, :create, :update, :destroy])
  end
end
