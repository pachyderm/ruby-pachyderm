require 'pachyderm'
require 'minitest/autorun'

$address = "127.0.0.1:30650"

class TestClientConnection < Minitest::Test
    def setup
		@client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
    end

    def test_cluster_connection
		client = Versionpb::API::Stub.new($address, :this_channel_is_insecure)
		req = Google::Protobuf::Empty.new
		resp = client.get_version(req)
		puts "resp: #{resp}\n"
		version = "#{resp.major}.#{resp.minor}.#{resp.micro}"
		unless resp.additional == ""
			version += "#{resp.additional}"
		end
		puts "version: #{version}"
		assert_equal "1.7.3",version
    end

    def test_unary_response
    end

	def test_empty_request
	end

	def test_param_request
	end

    def test_pfs
    end

    def test_pps
    end

    def test_error_response
    end

    def test_auth
    end

    def test_streaming_response
    end

end
