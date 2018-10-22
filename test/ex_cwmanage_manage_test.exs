defmodule ExCwmanageManageTest do
  use ExUnit.Case
  doctest ExCwmanage.Manage

  test "get system info" do
    ver = 
      ExCwmanage.Manage.System.info
      |> Map.fetch!("version")
    assert String.contains?(ver, "v2018")
  end
  
end
