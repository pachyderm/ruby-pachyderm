# Ruby Pachyderm Client


A ruby client wrapper for the Pachyderm API

## Example Installation

```
$ gem install pachyderm
```

[The gem is hosted on rubygems](https://rubygems.org/gems/pachyderm)

The `Major.Minor.Point.Micro` versioning is aligned with versioned releases of [Pachyderm](http://github.com/pachyderm/pachyderm/releases).

So version `1.7.3.9` of this gem, was built against version `1.7.3` of the Pachyderm API (proto / grpc definitions).

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
