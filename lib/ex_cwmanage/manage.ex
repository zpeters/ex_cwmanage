defmodule ExCwmanage.Manage do
  @moduledoc """
  Common commands that use the api
  """
end

defmodule ExCwmanage.Manage.Contacts do
  @moduledoc """
  Some shortcuts for Contacts
  """

  defp api_client, do: Application.get_env(:ex_cwmanage, :connectwise_api)

  def get_contacts_for_company(companyid) do
    {:ok, contacts} =
      api_client().get(
        '/company/contacts?conditions=company/identifier="#{companyid}"&fields=id,firstName,lastName,email'
      )

    contacts
    |> Enum.map(&Map.put(&1, "email", get_email_for_contact(&1["id"])))
  end

  defp get_email_for_contact(contactid) do
    {:ok, comms} = api_client().get('/company/contacts/#{contactid}/communications')

    comms
    |> Enum.filter(&(Map.get(&1, "communicationType") == "Email"))
    |> Enum.map(&Map.fetch!(&1, "value"))
  end
end

defmodule ExCwmanage.Manage.System do
  @moduledoc """
  Some shortcuts for System
  """
  defp api_client, do: Application.get_env(:ex_cwmanage, :connectwise_api)

  def info do
    {:ok, resp} = api_client().get("/system/info")
    resp
  end

  def departments do
    {:ok, resp} = api_client().get("/system/departments")
    resp
  end

  def others do
    {:ok, resp} = api_client().get("/system/mycompany/other")
    resp
  end

  def services do
    {:ok, resp} = api_client().get("/system/mycompany/services")
    resp
  end
end
