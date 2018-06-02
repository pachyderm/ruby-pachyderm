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

    end

    class Client
        def initialize(address, token=nil)
            @clients = {}
            clients = Pachyderm.constants
            # Omit the enterprise client
            # It has a collision w the 'auth.activate' call
            # and really you only use enterprise to administrate, and 
            # make that activate call once
            # And. If you really need to call it via the ruby client,
            # you can do so explicitly a la `Pachyderm::Enterprise::API::Stub.new ...`
            clients.delete(:Enterprise)
            clients.each do |sub_client_name|
                sub_client = Pachyderm.const_get sub_client_name
                next unless sub_client.const_defined? :API
                @clients[sub_client_name] = sub_client.const_get(:API).const_get(:Stub).new(address, :this_channel_is_insecure)
            end
            @token = token
        end

        # The one 'sugar' method we provide, since it needs to make a call
        # to both Pfs + Pps
        def delete_all
		    req = Google::Protobuf::Empty.new
            @clients[:Pfs].delete_all(req)
            @clients[:Pps].delete_all(req)
        end

        def method_missing(m, *args, &block)
            result = nil
            method_found = false
            @clients.each do |name, client|
                if client.respond_to? m
                    method_found = true
                    args << metadata unless @token.nil?
                    result = client.send(m, *args, &block)
                end
            end
            raise Exception.new("method #{m} not found") unless method_found
            result
        end

		def metadata()
			# The 'authn-token' is a keyname hardcoded at:
			# https://github.com/pachyderm/pachyderm/blob/master/src/client/auth/auth.go#L14
			# TODO - as part of the 'make sync' build task, pull in this value
			{:metadata => {'authn-token' => @token}}
		end
    end
end
