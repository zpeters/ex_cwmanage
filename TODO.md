# TODO

** Example condition - this needs to be documented
iex(9)> ExCwmanage.Api.HTTPClient.get_http("/company/companies", [conditions: "identifier='buscominc'", fields: "id"])
Raw: [conditions: "identifier='buscominc'", fields: "id"]
https://api-na.myconnectwise.net/v4_6_release/apis/3.0/company/companies?conditions=identifier='buscominc'&fields=id
{:ok, [%{"id" => 250}]}
iex(10)> 

- [ ] mix credo for todos
- [ ]  better generate_options
- [ ] better handling for 404 (etc) responses
- [ ] need to rename the function calls inside of callbacks to be more agnostic?
- [ ] take a really good look at the api sandbox and behaviors, seems messy
- [ ] Implement post_form helper or document
 form = {:multipart, [{"RecordId", "#{recordId}"}, {"RecordType", "#{recordType}"},
                         {:file, file, {"form-data", [{:filename, Path.basename(file)}]}, []}]}
    ExCwmanage.Api.post("/system/documents", form)

