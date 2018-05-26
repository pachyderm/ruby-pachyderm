require 'pachyderm'
require 'minitest/autorun'

$address = "127.0.0.1:30650"

class TestClientConnection < Minitest::Test

    def test_auth
        # $ pachctl auth activate --initial-admin=robot:admin
		# negative control : shouldn't be able to list-admins w a client w no token
		#$ echo "${ADMIN_TOKEN}" | pachctl auth use-auth-token # authenticates you as the cluster admin
		# positive control : should be able to list admins
    end


end
