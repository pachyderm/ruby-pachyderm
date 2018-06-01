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
		assert_equal 0, resp.repo_info.size
	end

    def test_error_response
		delete_all
		client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
		req = Pfs::CreateRepoRequest.new(:repo=>Pfs::Repo.new(:name=>"foo_#%@#^"))
		err = nil
		begin
			client.create_repo(req)
		rescue GRPC::Unknown => e
			err = e
		end
		assert_match(/repo\sname\s.*?invalid/, err.to_s)
    end

    def test_streaming_calls
		delete_all
		client = Pfs::API::Stub.new($address, :this_channel_is_insecure)
		repo_name = "foo"
		content = "yabba dabba doo"

		# Create some content in a commit
		req = Pfs::CreateRepoRequest.new(:repo=>Pfs::Repo.new(:name =>repo_name))
		client.create_repo(req)
		repo = Pfs::Repo.new(:name =>repo_name)
		path = "/bar"
	
		commit = client.start_commit(Pfs::StartCommitRequest.new(
			:branch => "master",
			:parent => Pfs::Commit.new(
				:repo => repo,
			)
		))

		req = Pfs::PutFileRequest.new(
			:file => Pfs::File.new(
				:commit => commit,
				:path => path
			),
			:value => content
		)
		client.put_file([req].each)

		client.finish_commit(Pfs::FinishCommitRequest.new(
			:commit => commit
		))

		req = Pfs::GetFileRequest.new(
			:file => Pfs::File.new(
				:commit => commit,
				:path => path
			)
		)
		resps = client.get_file(req)
		resps = resps.collect {|i| i}
		assert_equal 1, resps.size
		assert_equal content, resps.first.value
    end

end
