# ExCwmanage 
[![Hex.pm](https://img.shields.io/hexpm/v/ex_cwmanage.svg)](https://hex.pm/packages/ex_cwmanage)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_cwmanage/ExCwmanage.html)
[![Build Status](https://travis-ci.org/zpeters/ex_cwmanage.svg?branch=master)](https://travis-ci.org/zpeters/ex_cwmanage)
[![Coverage Status](https://coveralls.io/repos/github/zpeters/ex_cwmanage/badge.svg)](https://coveralls.io/github/zpeters/ex_cwmanage)

## Required Configuration
The following configuration information is required to connect to the ConnectWise API.  This can be supplied through creating a `dev.secret.exs` and `prod.secret.exs` file or by setting environment variables (preferred for production).

### Obtaining required configuration
1. API root: This will be one of the following *site* urls with additional version information to create the api url.  This is subject to change.
 - api-au.myconnectwise.net
 - api-eu.myconnectwise.net
 - api-na.myconnectwise.net
 - Example API root url `https://api-na.myconnectwise.net/v4_6_release/apis/3.0/`
2. Company Id: When you log into connectwise this is your *Company Name*
3. Public and Private Key:  (Follow this guide https://docs.connectwise.com/ConnectWise_Documentation/090/040/010/010/060)
4. Create a "client id": https://developer.connectwise.com/ClientID 

### Using secret files
`dev.secret.exs` and `prod.secret.exs` are in the `config` folder and are called based on the environment you are in.  Below is an example file
```
use Mix.Config

config :ex_cwmanage,
  cw_api_root: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/",
  cw_companyid: "MYCOMPANYID",
  cw_publickey: "MYPUBLICKEY",
  cw_privatekey: "MYPRIVATEKEY"
  cw_clientid: "MYCLIENTID"
```
### Using environment variables
The following environment variables need to be set if you are not using a *secret* file. This is the recommended method for production.
-  `CW_API_ROOT`
-  `CW_COMPANYID`
-  `CW_PUBLICKEY`
-  `CW_PRIVATEKEY`
-  `CW_CLIENTID`

## Usage
### API Requests
The api follows the standard HTTP REST conventions outlined in the ConnectWise API
```
HTTP Methods

    POST
        Create entity or any non CRUD action
    GET
        Return entity or list of entities
    PUT
        Replace all fields on entity with supplied fields
    PATCH
        Update specific fields on an entity
    DELETE
        Remove entity
```
### Options
Different resources in the api allow addition options to be passed along using normal url "query" formatting.  Full details are available here https://developer.connectwise.com/Products/Manage/Developer_Guide#Query_String_Parameters

#### Examples
  `ExCwmanage.Api.get("/system/info")`
  
  `ExCwmanage.Api.get("/finances/invoices/count", [conditions: "id=1234"])`
  
  `ExCwmanage.Api.get("/finances/invoices", [conditions: "id=1234", orderBy: "id"])`

  `ExCwmanage.Api.get_page("/finances/invoices", [pagesize: 100, pageid: 123])`

### The ConnecWise API
https://developer.connectwise.com/Products/Manage/Developer_Guide


### Changes
- version 0.3.0 - removed version tag in accept header that bumps us up to the latest version of the API. 
The api *should* be backwards compatible but this is considered a breaking change.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_cwmanage` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_cwmanage, "~> 0.3.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_cwmanage](https://hexdocs.pm/ex_cwmanage).
