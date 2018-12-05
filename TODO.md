# TODO
- better handling for 404 (etc) responses
- need to rename the function calls inside of callbacks to be more agnostic?
- take a really good look at the api sandbox and behaviors, seems messy
- Implement post_form helper or document
 form = {:multipart, [{"RecordId", "#{recordId}"}, {"RecordType", "#{recordType}"},
                         {:file, file, {"form-data", [{:filename, Path.basename(file)}]}, []}]}
    ExCwmanage.Api.post("/system/documents", form)

