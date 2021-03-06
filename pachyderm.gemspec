Gem::Specification.new do |s|
  s.name        = 'pachyderm'
  s.version     = File.read("VERSION").strip + "." + File.read("BUILD").strip
  s.date        = '2018-05-31'
  s.summary     = "Client library for interacting with a Pachyderm cluster"
  s.description = "Client library for interacting with a Pachyderm cluster"
  s.authors     = ["Joe Doliner"]
  s.email       = 'jdoliner@pachyderm.io'
  s.files       = Dir.glob("lib/**/*")
  s.require_path = "lib"
  s.homepage    =
    'http://rubygems.org/gems/pachyderm'
  s.license       = 'Apache-2.0'

  s.add_runtime_dependency 'google-protobuf',  '~> 3.5'
  s.add_runtime_dependency 'grpc', '~> 1.12'

end
