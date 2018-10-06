defmodule ExCwmanage.Manage do
  @moduledoc """
  Common commands that use the api
  """
end

defmodule ExCwmanage.Manage.System do
  import ExCwmanage.Api

  def info() do
    {:ok, resp} = get("/system/info")
    resp
  end

  def departments() do
    {:ok, resp} = get("/system/departments")
    resp
  end

  def others() do
    {:ok, resp} = get("/system/mycompany/other")
    resp
  end

  def services() do
    {:ok, resp} = get("/system/mycompany/services")
    resp
  end

end
