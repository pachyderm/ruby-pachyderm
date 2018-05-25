require 'pachyderm'
require 'minitest/autorun'

$address = "127.0.0.1:30650"

class TestClientConnection < Minitest::Test
    def setup
    end

	def delete_all
		client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
		req = Google::Protobuf::Empty.new
		client.delete_all(req)
	end	

    def test_cluster_connection
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

    def test_unary_response
		delete_all
		client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
		req = Pfs::CreateRepoRequest.new(:repo=>Pfs::Repo.new(:name =>"foo"))
		client.create_repo(req)
		req = Pfs::ListRepoRequest.new()
		resp = client.list_repo(req)
		assert_equal 1, resp.repo_info.size
		assert_equal "foo", resp.repo_info.first.repo.name
    end

	def test_empty_request
		delete_all
		client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
		req = Pfs::ListRepoRequest.new()
		resp = client.list_repo(req)
		resp.repo_info.each do |repo_info|
			puts "#{repo_info.repo.name}"
		end
		assert_equal 0, resp.repo_info.size
	end

    def test_error_response
		delete_all
		client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
		req = Pfs::CreateRepoRequest.new(:repo=>Pfs::Repo.new(:name=>"foo_#%@#^"))
		err = nil
		begin
			resp, err = client.create_repo(req)
		rescue GRPC::Unknown => e
			err = e
		end
		assert_match(/repo\sname\s.*?invalid/, err.to_s)
    end

    def test_pfs
    end

    def test_pps
    end

    def test_auth
    end

    def test_streaming_response
    end

end
