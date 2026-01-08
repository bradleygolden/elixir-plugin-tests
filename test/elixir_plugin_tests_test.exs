defmodule ElixirPluginTestsTest do
  use ExUnit.Case
  doctest ElixirPluginTests

  test "greets the world" do
    assert ElixirPluginTests.hello() == :world
  end
end
