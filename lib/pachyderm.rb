Gem.find_files("client/**/*.rb").each { |path| require path }

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

    class Client
        def initialize(address, token=nil)
            @clients = {}
            Pachyderm.constants.each do |sub_client_name|
                sub_client = Pachyderm.const_get sub_client_name
                next unless sub_client.const_defined? :API
                @clients[sub_client_name] = sub_client.const_get(:API).const_get(:Stub).new(address, :this_channel_is_insecure)
            end
            @token = token
        end

        def method_missing(m, *args, &block)
            result = nil
            @clients.each do |name, client|
                if client.respond_to? m
                    result = client.send(m, *args, &block)
                end
            end
            result
        end
    end
end
