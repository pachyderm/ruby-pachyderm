# Ruby Pachyderm

Ruby Pachyderm Client

A ruby client wrapper for the Pachyderm_ API.


## Example Usage

```
require 'pachyderm'

client = Pachyderm::Client.new(address)
req = Google::Protobuf::Empty.new
res = client.list_repo(req)
res.repo_info.each {|r| puts r}

```

Or to specify session / use a logged in client, specify your authentication token:

```
require 'pachyderm'

client = Pachyderm::Client.new(address, token)
client.get_admins(Pachyderm::Auth::GetAdminsRequest.new)
```

[For more examples, refer to the tests](./test/test.rb)
