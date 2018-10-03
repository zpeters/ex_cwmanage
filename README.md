# ExCwmanage 
[![Build Status](https://travis-ci.org/zpeters/ex_cwmanage.svg?branch=master)](https://travis-ci.org/zpeters/ex_cwmanage)
[![Coverage Status](https://coveralls.io/repos/github/zpeters/ex_cwmanage/badge.svg)](https://coveralls.io/github/zpeters/ex_cwmanage)

# ALPHA - WORK IN PROGRESS - DO NOT USE

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

### Using secret files
`dev.secret.exs` and `prod.secret.exs` are in the `config` folder and are called based on the environment you are in.  Below is an example file
```
use Mix.Config

config :ex_cwmanage,
  cw_api_root: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/",
  cw_companyid: "MYCOMPANYID",
  cw_publickey: "MYPUBLICKEY",
  cw_privatekey: "MYPRIVATEKEY"
```
### Using environment variables
The following environment variables need to be set if you are not using a *secret* file. This is the recommended method for production.
-  `CW_API_ROOT`
-  `CW_COMPANYID`
-  `CW_PUBLICKEY`
-  `CW_PRIVATEKEY`

## Installation - NOT PUBLISHED TO HEX YET

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_cwmanage` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_cwmanage, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_cwmanage](https://hexdocs.pm/ex_cwmanage).
