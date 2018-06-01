# Ruby Pachyderm

Ruby Pachyderm Client

A ruby client wrapper for the Pachyderm_ API.


## Example Usage

```
require 'pachyderm'

client = Pachyderm::Pfs::API::Stub.new($address, :this_channel_is_insecure)
req = Google::Protobuf::Empty.new
res = client.list_repo(req)
res.repo_info.each {|r| puts r}

```

[For more examples, refer to the tests](./blob/master/test/test.rb)
