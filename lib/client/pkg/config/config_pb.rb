# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: client/pkg/config/config.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "Config" do
    optional :user_id, :string, 1
    optional :v1, :message, 2, "ConfigV1"
  end
  add_message "ConfigV1" do
    optional :pachd_address, :string, 2
    optional :session_token, :string, 1
  end
end

Config = Google::Protobuf::DescriptorPool.generated_pool.lookup("Config").msgclass
ConfigV1 = Google::Protobuf::DescriptorPool.generated_pool.lookup("ConfigV1").msgclass
