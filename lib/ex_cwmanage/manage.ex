defmodule ExCwmanage.Manage do
  @moduledoc """
  Common commands that use the api
  """
end

defmodule ExCwmanage.Manage.Contacts do
  import ExCwmanage.Api

  def get_contacts_for_company(companyid) do
    {:ok, contacts} = get('/company/contacts?conditions=company/identifier="#{companyid}"&fields=id,firstName,lastName,email')
    contacts
    |> Enum.map(&Map.put(&1, "email", get_email_for_contact(&1["id"])))
  end

  defp get_email_for_contact(contactid) do
     {:ok, comms} = get('/company/contacts/#{contactid}/communications')
    comms
    |> Enum.filter(&Map.get(&1, "communicationType") == "Email")
    |> Enum.map(&(Map.fetch!(&1, "value")))
  end

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
