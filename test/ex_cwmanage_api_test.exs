defmodule ExCwmanageApiTest do
  use ExUnit.Case
  doctest ExCwmanage

  alias ExCwmanage.Api, as: Api

  test "test get no conditions" do
    {:ok, resp} = Api.get("/system/info")
    assert is_map(resp)
    assert Map.has_key?(resp, "version")
  end

  test "test bad path" do
    {:error, resp} = Api.get("/badpath")
    assert resp == {:invalid, "<", 0}
  end

  test "get with conditions" do
    {:ok, resp} = Api.get("/service/locations")
    {:ok, resp2} = Api.get("/service/locations", [:conditions, "id=1"])
    assert length(resp) > 0
    assert length(resp2) > 0
    assert length(resp) > length(resp2)
  end

  # test "random endpoints" do
  #   endpoints = [
  #     "/company/addressFormats",
  #     "/company/companies",
  #     "/company/companies/#{random_id()}/customStatusNotes",
  #     "/company/companies/#{random_id()}/groups",
  #     "/company/companies/#{random_id()}/managementSummaryReports",
  #     "/company/noteTypes",
  #     "/company/companies/#{random_id()}/notes",
  #     "/company/companyPickerItems",
  #     "/company/companies/#{random_id()}/sites",
  #     "/company/companies/statuses",
  #     "/company/companies/#{random_id()}/teams",
  #     "/company/companies/types",
  #     "/company/configurations/statuses",
  #     "/company/configurations/types/#{random_id()}/questions",
  #     "/company/configurations/types",
  #     "/company/configurations",
  #     "/company/contacts/#{random_id()}/communications",
  #     "/company/contacts/departments",
  #     "/company/contacts/#{random_id()}/groups",
  #     "/company/contacts/#{random_id()}/notes",
  #     "/company/contacts/relationships"
  #   ]
  #   endpoints
  #   |> Enum.each(&(test_endpoint(&1)))

  # end

  # defp test_endpoint(endpoint) do
  #   IO.puts("\tTesting endpoint #{endpoint}")
  #   {:ok, resp} = Api.get(endpoint)
  #   IO.puts("\t\t #{inspect resp}")
  #   assert resp
  # end
  # defp random_id do
  #   Enum.random(1..999)
  # end
end
