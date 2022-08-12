defmodule UnLibDTest do
  use ExUnit.Case
  doctest UnLibD

  test "greets the world" do
    assert UnLibD.hello() == :world
  end
end
