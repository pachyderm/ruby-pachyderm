# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: client/deploy/deploy.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "deploy.DeployStorageSecretRequest" do
    map :secrets, :string, :bytes, 1
  end
  add_message "deploy.DeployStorageSecretResponse" do
  end
end

module Deploy
  DeployStorageSecretRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("deploy.DeployStorageSecretRequest").msgclass
  DeployStorageSecretResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("deploy.DeployStorageSecretResponse").msgclass
end
