defmodule ExCwmanage.Api.Sandbox do
  @moduledoc """
  API Sandbox for testing and dev
  """
  @behaviour ExCwmanage.Api

  def get(path, params) do
    get_http(path, params)
  end

  def get_stream(path, params) do
    get_http_stream(path, params)
  end


  def get_page(path, params) do
    get_http_page(path, params)
  end

  def get_raw(path, params) do
    get_http_raw(path, params)
  end

  def get_http_stream("/system/members", fields: "id") do
    {:ok,
    [
      %{"id" => 149},
      %{"id" => 150},
      %{"id" => 151},
      %{"id" => 152},
      %{"id" => 153},
      %{"id" => 154},
      %{"id" => 155},
      %{"id" => 156},
      %{"id" => 157},
      %{"id" => 158},
      %{"id" => 159},
      %{"id" => 160},
      %{"id" => 161},
      %{"id" => 162},
      %{"id" => 163},
      %{"id" => 164},
      %{"id" => 165},
      %{"id" => 166},
      %{"id" => 167},
      %{"id" => 168},
      %{"id" => 169},
      %{"id" => 170},
      %{"id" => 171},
      %{"id" => 172},
      %{"id" => 173},
      %{"id" => 174},
      %{"id" => 175},
      %{"id" => 176},
      %{"id" => 177},
      %{"id" => 178},
      %{"id" => 179},
      %{"id" => 180},
      %{"id" => 181},
      %{"id" => 182},
      %{"id" => 183},
      %{"id" => 184},
      %{"id" => 185},
      %{"id" => 186},
      %{"id" => 187},
      %{"id" => 188},
      %{"id" => 189},
      %{"id" => 190},
      %{"id" => 191},
      %{"id" => 192},
      %{"id" => 193},
      %{"id" => 194},
      %{"id" => 195}
    ]}

  end

  def get_http("/service/locations", conditions: "id=1") do
    {:ok,
     [
       %{
         "_info" => %{
           "lastUpdated" => "2010-08-02T11:58:04Z",
           "updatedBy" => "abellini"
         },
         "defaultFlag" => false,
         "id" => 1,
         "name" => "On-Site",
         "where" => "OnSite"
       }
     ]}
  end

  def get_http(path, []) do
    case path do
      "/system/info" ->
        {:ok,
         %{
           "isCloud" => true,
           "licenseBits" => [
             %{"activeFlag" => true, "name" => "PocketPC"},
             %{"activeFlag" => true, "name" => "EmailConnector"},
             %{"activeFlag" => false, "name" => "ADPInterface"},
             %{"activeFlag" => true, "name" => "GLInterface"},
             %{"activeFlag" => true, "name" => "PremiumPortal"},
             %{"activeFlag" => true, "name" => "ManagedServices"},
             %{"activeFlag" => true, "name" => "SpamStats"},
             %{"activeFlag" => true, "name" => "AuditTrail"},
             %{"activeFlag" => false, "name" => "QuoteWerks"},
             %{"activeFlag" => true, "name" => "ConnectWiseNetwork"},
             %{"activeFlag" => true, "name" => "Inventory"},
             %{"activeFlag" => true, "name" => "Purchasing"},
             %{"activeFlag" => true, "name" => "IzendaReports"},
             %{"activeFlag" => true, "name" => "SalesManagement"},
             %{"activeFlag" => true, "name" => "KnowledgeBase"},
             %{"activeFlag" => true, "name" => "Agreement"},
             %{"activeFlag" => true, "name" => "AgileBoard"},
             %{"activeFlag" => true, "name" => "Marketing"},
             %{"activeFlag" => true, "name" => "StreamlineIT"},
             %{"activeFlag" => true, "name" => "Subcontractor"},
             %{"activeFlag" => true, "name" => "CustomFields"},
             %{"activeFlag" => true, "name" => "ManageLogin"}
           ],
           "serverTimeZone" => "Eastern Standard Time",
           "version" => "v2018.2.53326"
         }}

      "/service/locations" ->
        {:ok,
         [
           %{
             "_info" => %{
               "lastUpdated" => "2010-08-02T11:58:04Z",
               "updatedBy" => "abellini"
             },
             "defaultFlag" => false,
             "id" => 1,
             "name" => "On-Site",
             "where" => "OnSite"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2010-08-02T11:58:00Z",
               "updatedBy" => "abellini"
             },
             "defaultFlag" => false,
             "id" => 2,
             "name" => "In-house",
             "where" => "InHouse"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2010-08-02T11:58:17Z",
               "updatedBy" => "abellini"
             },
             "defaultFlag" => true,
             "id" => 4,
             "name" => "Remote",
             "where" => "Remote"
           }
         ]}

      _ ->
        {:error, {:invalid, "<", 0}}
    end
  end

  def get_http_raw(_path, _params) do
    {:ok, "a string is a binary"}
  end

  def get_http_page(_path, _params) do
    {:ok, 123, %{}}
  end

  def post(path, payload) do
    post_http(path, payload)
  end

  def post_http(_path, _payload) do
    :ok
  end

  def put(path, payload) do
    put_http(path, payload)
  end

  def put_http(_path, _payload) do
    :ok
  end

  def delete(path, parameters) do
    delete_http(path, parameters)
  end

  def delete_http(_path, _parameters) do
    :ok
  end

  def patch(path, payload) do
    patch_http(path, payload)
  end

  def patch_http(_path, _payload) do
    :ok
  end
end
