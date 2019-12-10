defmodule ExCwmanageApiTest do
  use ExUnit.Case
  doctest ExCwmanage

  import Mox
  setup :verify_on_exit!

  @mock ExCwmanage.Api.Mock

  describe "get_stream/1 and get_stream/2" do
    test "get a stream" do
      @mock
      |> expect(:get_stream, fn _path, _params ->
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
      end)

      path = "/system/members"
      params = [fields: "id", pagesize: 1]
      {:ok, results} = ExCwmanage.Api.get_stream(path, params)
      assert results != nil
    end
  end

  test "test get page default" do
    @mock
    |> expect(:get_page, fn _path, _param ->
      {:ok, 10, [%{:name => :company1}, %{:name => :compan2}, %{:name => :company3}]}
    end)

    {:ok, next, resp} = ExCwmanage.Api.get_page("/company/companies")
    assert next != nil
    assert next > 0
    assert is_list(resp)
  end

  test "test get raw page (no json)" do
    @mock
    |> expect(:get_raw, fn _path, _params ->
      {:ok,
       "{\"version\":\"v2019.5.68761\",\"isCloud\":true,\"serverTimeZone\":\"Eastern Standard Time\",\"licenseBits\":[{\"name\":\"PocketPC\",\"activeFlag\":true},{\"name\":\"EmailConnector\",\"activeFlag\":true},{\"name\":\"ADPInterface\",\"activeFlag\":false},{\"name\":\"GLInterface\",\"activeFlag\":true},{\"name\":\"PremiumPortal\",\"activeFlag\":true},{\"name\":\"ManagedServices\",\"activeFlag\":true},{\"name\":\"SpamStats\",\"activeFlag\":false},{\"name\":\"AuditTrail\",\"activeFlag\":true},{\"name\":\"QuoteWerks\",\"activeFlag\":false},{\"name\":\"ConnectWiseNetwork\",\"activeFlag\":true},{\"name\":\"Inventory\",\"activeFlag\":true},{\"name\":\"Purchasing\",\"activeFlag\":true},{\"name\":\"IzendaReports\",\"activeFlag\":true},{\"name\":\"SalesManagement\",\"activeFlag\":true},{\"name\":\"KnowledgeBase\",\"activeFlag\":true},{\"name\":\"Agreement\",\"activeFlag\":true},{\"name\":\"AgileBoard\",\"activeFlag\":true},{\"name\":\"Marketing\",\"activeFlag\":true},{\"name\":\"StreamlineIT\",\"activeFlag\":true},{\"name\":\"Subcontractor\",\"activeFlag\":true},{\"name\":\"CustomFields\",\"activeFlag\":true},{\"name\":\"ManageLogin\",\"activeFlag\":true},{\"name\":\"SessionLockout\",\"activeFlag\":true},{\"name\":\"MobileSessionLockout\",\"activeFlag\":true}],\"cloudRegion\":\"NA\"}"}
    end)

    {:ok, resp} = ExCwmanage.Api.get_raw("/system/info")
    assert is_binary(resp)
  end

  test "test get no conditions" do
    @mock
    |> expect(:get, fn _path, _params ->
      {:ok,
       %{
         "cloudRegion" => "NA",
         "isCloud" => true,
         "licenseBits" => [
           %{"activeFlag" => true, "name" => "PocketPC"},
           %{"activeFlag" => true, "name" => "EmailConnector"},
           %{"activeFlag" => false, "name" => "ADPInterface"},
           %{"activeFlag" => true, "name" => "GLInterface"},
           %{"activeFlag" => true, "name" => "PremiumPortal"},
           %{"activeFlag" => true, "name" => "ManagedServices"},
           %{"activeFlag" => false, "name" => "SpamStats"},
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
           %{"activeFlag" => true, "name" => "ManageLogin"},
           %{"activeFlag" => true, "name" => "SessionLockout"},
           %{"activeFlag" => true, "name" => "MobileSessionLockout"}
         ],
         "serverTimeZone" => "Eastern Standard Time",
         "version" => "v2019.5.68761"
       }}
    end)

    {:ok, resp} = ExCwmanage.Api.get("/system/info")
    assert is_map(resp)
    assert Map.has_key?(resp, "version")
  end

  test "test bad path" do
    @mock
    |> expect(:get, fn _path, _params ->
      {:error,
       %HTTPoison.Response{
         body:
           "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\"/>\r\n<title>404 - File or directory not found.</title>\r\n<style type=\"text/css\">\r\n<!--\r\nbody{margin:0;font-size:.7em;font-family:Verdana, Arial, Helvetica, sans-serif;background:#EEEEEE;}\r\nfieldset{padding:0 15px 10px 15px;} \r\nh1{font-size:2.4em;margin:0;color:#FFF;}\r\nh2{font-size:1.7em;margin:0;color:#CC0000;} \r\nh3{font-size:1.2em;margin:10px 0 0 0;color:#000000;} \r\n#header{width:96%;margin:0 0 0 0;padding:6px 2% 6px 2%;font-family:\"trebuchet MS\", Verdana, sans-serif;color:#FFF;\r\nbackground-color:#555555;}\r\n#content{margin:0 0 0 2%;position:relative;}\r\n.content-container{background:#FFF;width:96%;margin-top:8px;padding:10px;position:relative;}\r\n-->\r\n</style>\r\n</head>\r\n<body>\r\n<div id=\"header\"><h1>Server Error</h1></div>\r\n<div id=\"content\">\r\n <div class=\"content-container\"><fieldset>\r\n  <h2>404 - File or directory not found.</h2>\r\n  <h3>The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.</h3>\r\n </fieldset></div>\r\n</div>\r\n</body>\r\n</html>\r\n",
         headers: [
           {"Content-Type", "text/html"},
           {"Content-Length", "1245"},
           {"Connection", "keep-alive"},
           {"Date", "Tue, 10 Dec 2019 18:12:05 GMT"},
           {"Server", "Microsoft-IIS/8.5"},
           {"Strict-Transport-Security", "max-age=31536000; includeSubDomains"},
           {"x-server-name", "IP-0A0A0791"},
           {"x-cw-request-id", "8a1d4a2d-359c-4a82-abb2-6529d97f59f9"},
           {"X-Powered-By", "ASP.NET"},
           {"X-Content-Type-Options", "nosniff"},
           {"X-Xss-Protection", "1; mode=block"},
           {"Content-Security-Policy",
            "default-src 'self' 'unsafe-inline' 'unsafe-eval' blob: *.walkme.com *.connectwise *.connectwise.com az416426.vo.msecnd.net dc.services.visualstudio.com/v2/track *.connectwisedev.com *.myconnectwise.net cwview.com *.wise-pay.com *.wise-sync.com; font-src 'self' 'unsafe-inline' 'unsafe-eval' *.walkme.com *.connectwise.com *.googleapis.com; img-src * data: snapshot:; frame-src * data:; connect-src 'self' *.walkme.com *.connectwise.com *.connectwisedev.com *.myconnectwise.net cwview.com dc.services.visualstudio.com/v2/track cheetah quotewerks://* wss://*.amazonaws.com;"},
           {"Vary", "Accept-Encoding"},
           {"X-Cache", "Error from cloudfront"},
           {"Via", "1.1 6a7984963592cffd5cf08d03af7ea683.cloudfront.net (CloudFront)"},
           {"X-Amz-Cf-Pop", "IAH50-C1"},
           {"X-Amz-Cf-Id", "2cw2JjU1LnwlzxAyttp71FHcQtiUqKLm5Zwq2XV5yI3pufRX5faOTg=="}
         ],
         request: %HTTPoison.Request{
           body: "",
           headers: [
             Authorization: "Basic YnVzY29taW5jK1o2bHNxdVZhUG83RE1mNVI6TEo3ZW83SjQ5NnNwUWlkcA==",
             Accept: "application/vnd.connectwise.com+json",
             "Content-Type": "application/json",
             clientId: "73772398-7364-4a94-9689-c3e95d294a43"
           ],
           method: :get,
           options: [timeout: 12_000, recv_timeout: 12_000],
           params: %{},
           url: "https://api-na.myconnectwise.net/v2019_5/apis/3.0/badpath"
         },
         request_url: "https://api-na.myconnectwise.net/v2019_5/apis/3.0/badpath",
         status_code: 404
       }}
    end)

    {:error, resp} = ExCwmanage.Api.get("/badpath")
    assert resp.status_code == 404
  end

  test "get with conditions" do
    @mock
    |> expect(:get, fn _path, _params ->
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
         },
         %{
           "_info" => %{
             "lastUpdated" => "2018-11-07T13:32:33Z",
             "updatedBy" => "ZPeters"
           },
           "defaultFlag" => false,
           "id" => 5,
           "name" => "BCI - Large Conference Room",
           "where" => "InHouse"
         },
         %{
           "_info" => %{
             "lastUpdated" => "2018-11-07T13:32:45Z",
             "updatedBy" => "ZPeters"
           },
           "defaultFlag" => false,
           "id" => 6,
           "name" => "BCI - Small Conference Room",
           "where" => "InHouse"
         },
         %{
           "_info" => %{
             "lastUpdated" => "2018-11-07T13:32:57Z",
             "updatedBy" => "ZPeters"
           },
           "defaultFlag" => false,
           "id" => 7,
           "name" => "Webex",
           "where" => "Remote"
         }
       ]}
    end)

    {:ok, resp} = ExCwmanage.Api.get("/service/locations")

    @mock
    |> expect(:get, fn _path, _params ->
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
    end)

    {:ok, resp2} = ExCwmanage.Api.get("/service/locations", conditions: "id=1")
    assert length(resp) > 0
    assert length(resp2) > 0
    assert length(resp) > length(resp2)
  end

  test "post function returns placeholder :ok" do
    @mock
    |> expect(:post, fn _path, _payload ->
      {:ok, %{}}
    end)

    {:ok, resp} = ExCwmanage.Api.post("/", %{})
    assert is_map(resp)
  end

  test "patch function returns placeholder :ok" do
    @mock
    |> expect(:patch, fn _path, _payload ->
      {:ok, %{}}
    end)

    {:ok, resp} = ExCwmanage.Api.patch("/", %{})
    assert is_map(resp)
  end

  test "put function returns placeholder :ok" do
    @mock
    |> expect(:put, fn _path, _payload ->
      {:ok, %{}}
    end)

    {:ok, resp} = ExCwmanage.Api.put("/", %{})
    assert is_map(resp)
  end

  test "delete function returns placeholder :ok" do
    @mock
    |> expect(:delete, fn _path, _params ->
      {:ok, %{}}
    end)

    {:ok, resp} = ExCwmanage.Api.delete("/")
    assert is_map(resp)
  end
end
