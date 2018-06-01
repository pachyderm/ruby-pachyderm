# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: client/auth/auth.proto for package 'auth'

require 'grpc'
require 'client/auth/auth_pb'

module Pachyderm
module Auth
  module API
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'auth.API'

      # Activate/Deactivate the auth API. 'Activate' sets an initial set of admins
      # for the Pachyderm cluster, and 'Deactivate' removes all ACLs, tokens, and
      # admins from the Pachyderm cluster, making all data publicly accessable
      rpc :Activate, ActivateRequest, ActivateResponse
      rpc :Deactivate, DeactivateRequest, DeactivateResponse
      # GetAdmins returns the current list of cluster admins
      rpc :GetAdmins, GetAdminsRequest, GetAdminsResponse
      # ModifyAdmins adds or removes admins from the cluster
      rpc :ModifyAdmins, ModifyAdminsRequest, ModifyAdminsResponse
      rpc :Authenticate, AuthenticateRequest, AuthenticateResponse
      rpc :Authorize, AuthorizeRequest, AuthorizeResponse
      rpc :WhoAmI, WhoAmIRequest, WhoAmIResponse
      rpc :GetScope, GetScopeRequest, GetScopeResponse
      rpc :SetScope, SetScopeRequest, SetScopeResponse
      rpc :GetACL, GetACLRequest, GetACLResponse
      rpc :SetACL, SetACLRequest, SetACLResponse
      rpc :GetAuthToken, GetAuthTokenRequest, GetAuthTokenResponse
      rpc :ExtendAuthToken, ExtendAuthTokenRequest, ExtendAuthTokenResponse
      rpc :RevokeAuthToken, RevokeAuthTokenRequest, RevokeAuthTokenResponse
      rpc :SetGroupsForUser, SetGroupsForUserRequest, SetGroupsForUserResponse
      rpc :ModifyMembers, ModifyMembersRequest, ModifyMembersResponse
      rpc :GetGroups, GetGroupsRequest, GetGroupsResponse
      rpc :GetUsers, GetUsersRequest, GetUsersResponse
    end

    Stub = Service.rpc_stub_class
  end
end
end
