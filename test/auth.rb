require 'pachyderm'
require 'minitest/autorun'

$address = "127.0.0.1:30650"

class TestClientConnection < Minitest::Test

    def test_auth
		client = Pachyderm::Auth::API::Stub.new($address, :this_channel_is_insecure)

		# Negative control - can't list admins prior to enabling auth
		e = nil
		begin	
			client.get_admins(Pachyderm::Auth::GetAdminsRequest.new)
		rescue GRPC::Unimplemented => e
			assert_equal false, e.nil?
		end	

		# Activate auth w an admin
		name="robot:admin"
		req = Pachyderm::Auth::ActivateRequest.new(:subject=>name)
		res = client.activate(req)
		token = res.pach_token

		# Negative control - can't list admins prior to logging in 
		# (and in this case omitting a session token)
		e = nil
		begin	
			client.get_admins(Pachyderm::Auth::GetAdminsRequest.new)
		rescue GRPC::Unauthenticated => e
			assert_equal false, e.nil?
		end	

		# Positive control - should be able to list admins
		metadata = Pachyderm::metadata(token)
		res = client.get_admins(Pachyderm::Auth::GetAdminsRequest.new, metadata)
		refute_equal 0, res.admins.size
    end


end
