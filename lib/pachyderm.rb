require 'client/pfs/pfs_pb'
require 'client/pfs/pfs_services_pb'
require 'client/version/versionpb/version_pb'
require 'client/version/versionpb/version_services_pb'
require 'client/auth/auth_pb'
require 'client/auth/auth_services_pb'

module Pachyderm
    class << self
		def LoggedIn?(token)
			raise Exception.new("user token required") if token.nil?
			client = Auth::API::Stub.new($address, :this_channel_is_insecure)
			begin
				res = client.whoami(Auth::WhoAmIRequest.new, metadata(token))
				puts "logged in as #{res.username}, admin? #{res.is_admin}\n"
			rescue GRPC::Unauthenticated 
				return false
			end
			return true
		end

		def metadata(token)
			# The 'authn-token' is a keyname hardcoded at:
			# https://github.com/pachyderm/pachyderm/blob/master/src/client/auth/auth.go#L14
			# TODO - as part of the 'make sync' build task, pull in this value
			{:metadata => {'authn-token' => token}}
		end
    end
end
