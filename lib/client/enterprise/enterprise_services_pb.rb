# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: client/enterprise/enterprise.proto for package 'enterprise'

require 'grpc'
require 'client/enterprise/enterprise_pb'

module Enterprise
  module API
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'enterprise.API'

      # Provide a Pachyderm enterprise token, enabling Pachyderm enterprise
      # features, such as the Pachyderm Dashboard and Auth system
      rpc :Activate, ActivateRequest, ActivateResponse
      rpc :GetState, GetStateRequest, GetStateResponse
      # Deactivate is a testing API. It removes a cluster's enterprise activation
      # token and sets its enterprise state to NONE (normally, once a cluster has
      # been activated, the only reachable state is EXPIRED).
      #
      # NOTE: This endpoint also calls DeleteAll (and deletes all Pachyderm data in
      # its cluster). This is to avoid dealing with invalid, intermediate states
      # (e.g. auth is activated but enterprise state is NONE)
      rpc :Deactivate, DeactivateRequest, DeactivateResponse
    end

    Stub = Service.rpc_stub_class
  end
end