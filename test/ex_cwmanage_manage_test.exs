defmodule ExCwmanageManageTest do
  use ExUnit.Case
  doctest ExCwmanage.Manage

  import Mox
  setup :verify_on_exit!

  alias ExCwmanage.Manage.Contacts
  alias ExCwmanage.Manage.System

  @mock ExCwmanage.Api.Mock

  describe "get_contacts_for_company/1" do
    test "get XYZ TEST CO" do
      @mock
      |> expect(:get, fn _path ->
        {:ok,
         [
           %{"firstName" => "Zach", "id" => 16, "lastName" => "Peters"}
         ]}
      end)
      |> expect(:get, fn _path ->
        {:ok,
         [
           %{
             "_info" => %{
               "contactMobileGuid" => "7b2b888f-e136-4754-99b6-72a7e8f41f42",
               "lastUpdated" => "2017-09-08T18:12:43Z",
               "updatedBy" => "mweems"
             },
             "communicationType" => "Phone",
             "contactId" => 16,
             "defaultFlag" => true,
             "extension" => "",
             "id" => 44_106,
             "mobileGuid" => "b83cea56-9a7b-4d55-98e2-3ed09c3f723b",
             "type" => %{"id" => 2, "name" => "Direct"},
             "value" => "6014274161"
           },
           %{
             "_info" => %{
               "contactMobileGuid" => "7b2b888f-e136-4754-99b6-72a7e8f41f42",
               "lastUpdated" => "2015-07-15T13:06:29Z",
               "updatedBy" => "Import1"
             },
             "communicationType" => "Email",
             "contactId" => 16,
             "defaultFlag" => true,
             "domain" => "@bcianswers.com",
             "extension" => "",
             "id" => 44_107,
             "mobileGuid" => "fe3a1990-bc38-4de1-b5af-c38a550d4824",
             "type" => %{"id" => 1, "name" => "Email"},
             "value" => "zpeters@bcianswers.com"
           }
         ]}
      end)

      companyid = "buscominc"
      contacts = Contacts.get_contacts_for_company(companyid)
      assert is_list(contacts)
      assert Enum.count(contacts) == 1

      first_contact = List.first(contacts)
      assert first_contact["firstName"] == "Zach"
      assert first_contact["email"] == ["zpeters@bcianswers.com"]
    end
  end

  describe "info/0" do
    test "get info" do
      @mock
      |> expect(:get, fn _path ->
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

      resp = System.info()
      assert is_map(resp)
      assert resp["serverTimeZone"] == "Eastern Standard Time"
    end
  end

  describe "departments/0" do
    test "get departments" do
      @mock
      |> expect(:get, fn _path ->
        {:ok,
         [
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:35:27Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 1,
             "identifier" => "Service Desk",
             "name" => "Service Desk"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-18T18:40:22Z",
               "updatedBy" => "zAdmin"
             },
             "id" => 2,
             "identifier" => "Data Center",
             "name" => "Route & Switch"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:34:51Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 3,
             "identifier" => "Operations",
             "name" => "Operations"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:35:19Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 10,
             "identifier" => "Sales",
             "name" => "Sales"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:34:22Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 11,
             "identifier" => "Collaboration",
             "name" => "Collaboration"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:35:46Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 12,
             "identifier" => "Wireless & Secu",
             "name" => "Wireless & Security"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:35:37Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 13,
             "identifier" => "Storage & Vir",
             "name" => "Storage & Virtualization"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-14T18:29:12Z",
               "updatedBy" => "zAdmin"
             },
             "id" => 14,
             "identifier" => "Route & Switch",
             "name" => "Z-Route & Switch-DO NOT USE"
           },
           %{
             "_info" => %{
               "lastUpdated" => "2017-09-08T23:35:07Z",
               "updatedBy" => "ZPeters"
             },
             "id" => 16,
             "identifier" => "PRODUCT ONLY",
             "name" => "PRODUCT ONLY"
           }
         ]}
      end)

      resp = System.departments()
      assert is_list(resp)
    end
  end

  describe "others/0" do
    test "get others" do
      @mock
      |> expect(:get, fn _path ->
        {:ok,
         [
           %{
             "_info" => %{
               "lastUpdated" => "2019-10-04T13:39:51Z",
               "updatedBy" => "BHatten"
             },
             "contactSync" => "CFL",
             "defaultAddressFormat" => %{"_info" => %{}, "id" => 1, "name" => "Default"},
             "defaultCalendar" => %{
               "_info" => %{
                 "calendar_href" =>
                   "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/schedule/calendars/1"
               },
               "id" => 1,
               "name" => "Standard Office Hours"
             },
             "defaultFromAddress" => "noreply@bcianswers.com",
             "id" => 1,
             "includePortalLinkFlag" => false,
             "locale" => %{
               "_info" => %{
                 "Locale_href" =>
                   "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/system/info/locales/1"
               },
               "id" => 1,
               "name" => "English (United States)"
             },
             "logoPath" => "\\\\PSANA-OSS1\\uploaded_docs\\buscominc",
             "portalUrlOverride" => "bci.myportallogin.com",
             "serverTimeZone" => %{
               "_info" => %{
                 "timeZoneSetup_href" =>
                   "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/system/timeZoneSetups/1"
               },
               "id" => 1,
               "name" => "GMT-5/Eastern Time: US & Canada"
             },
             "siteUrl" => "na.myconnectwise.net",
             "syncLeadsFlag" => false,
             "useExpandedFormatActivityFlag" => true,
             "useExpandedFormatTimeFlag" => false,
             "useSslFlag" => true
           }
         ]}
      end)

      resp = System.others()
      assert is_list(resp)
      first_result = List.first(resp)
      assert first_result["siteUrl"] == "na.myconnectwise.net"
    end
  end

  describe "services/0" do
    test "get services" do
      @mock
      |> expect(:get, fn _path ->
        {:ok,
         [
           %{
             "_info" => %{
               "lastUpdated" => "2019-10-04T13:39:51Z",
               "updatedBy" => "BHatten"
             },
             "allowCCFlag" => false,
             "allowTOFlag" => false,
             "calendarSetup" => %{
               "_info" => %{
                 "calendarSetup_href" =>
                   "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/system/mycompany/portalcalendar/1"
               },
               "id" => 1
             },
             "contactColor" => "#CEE2FB",
             "contactColorDisableFlag" => false,
             "headerColor" => "#DDD9C3",
             "headerColorDisableFlag" => false,
             "hideDelimiterFlag" => false,
             "id" => 1,
             "memberColor" => "#D6E3BC",
             "memberColorDisableFlag" => false,
             "scheduleSpan" => "OfficeHours",
             "srNotify" => "All",
             "unknownColor" => "#C0C0C0",
             "unknownColorDisableFlag" => false
           }
         ]}
      end)

      resp = System.services()
      assert is_list(resp)
      first_result = List.first(resp)
      assert first_result["id"] == 1
    end
  end
end
