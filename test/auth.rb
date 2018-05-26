require 'pachyderm'
require 'minitest/autorun'

$address = "127.0.0.1:30650"

class TestClientConnection < Minitest::Test

    def test_auth
		client = Versionpb::API::Stub.new($address, :this_channel_is_insecure)
		req = Google::Protobuf::Empty.new
		resp = client.get_version(req)
		version = "#{resp.major}.#{resp.minor}.#{resp.micro}"
		unless resp.additional == ""
			version += "#{resp.additional}"
		end
		expected_version = File.read("VERSION").strip
		assert_equal expected_version,version
    end


end
