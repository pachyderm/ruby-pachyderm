require 'client/pfs/pfs_pb'
require 'client/pfs/pfs_services_pb'

module Pachyderm
    class << self

        def new_client

        end

    end

	class Client

		def gogogo

			stub = Pfs::API::Stub.new('127.0.0.1:30650',
											   :this_channel_is_insecure)
			req = Pfs::ListRepoRequest.new()
			puts "req: #{req}\n"

			resp = stub.list_repo(req)

			puts "resp: #{resp}\n"
			resp.repo_info.each do |repo_info|
				puts "#{repo_info.repo.name}"
			end

		end

	end

end


c = Pachyderm::Client.new

c.gogogo()

