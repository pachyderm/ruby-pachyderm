# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: client/enterprise/enterprise.proto

require 'google/protobuf'

require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "enterprise.EnterpriseRecord" do
    optional :activation_code, :string, 1
    optional :expires, :message, 2, "google.protobuf.Timestamp"
  end
  add_message "enterprise.TokenInfo" do
    optional :expires, :message, 1, "google.protobuf.Timestamp"
  end
  add_message "enterprise.ActivateRequest" do
    optional :activation_code, :string, 1
    optional :expires, :message, 2, "google.protobuf.Timestamp"
  end
  add_message "enterprise.ActivateResponse" do
    optional :info, :message, 1, "enterprise.TokenInfo"
  end
  add_message "enterprise.GetStateRequest" do
  end
  add_message "enterprise.GetStateResponse" do
    optional :state, :enum, 1, "enterprise.State"
    optional :info, :message, 2, "enterprise.TokenInfo"
  end
  add_message "enterprise.DeactivateRequest" do
  end
  add_message "enterprise.DeactivateResponse" do
  end
  add_enum "enterprise.State" do
    value :NONE, 0
    value :ACTIVE, 1
    value :EXPIRED, 2
  end
end

module Enterprise
  EnterpriseRecord = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.EnterpriseRecord").msgclass
  TokenInfo = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.TokenInfo").msgclass
  ActivateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.ActivateRequest").msgclass
  ActivateResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.ActivateResponse").msgclass
  GetStateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.GetStateRequest").msgclass
  GetStateResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.GetStateResponse").msgclass
  DeactivateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.DeactivateRequest").msgclass
  DeactivateResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.DeactivateResponse").msgclass
  State = Google::Protobuf::DescriptorPool.generated_pool.lookup("enterprise.State").enummodule
end
