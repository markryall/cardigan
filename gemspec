Gem::Specification.new do |spec|
  spec.name = 'cardigan'
  spec.version = '0.1.0'
  spec.summary = "command line utility for managing cards (tasks, bugs, stories or whatever)"
  spec.description = <<-EOF
A command line utility that manages cards as individual files so that they can be added to a version control system
EOF

  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/cardigan'
 
  spec.files = Dir['lib/**/*'] + Dir['bin/*'] + ['README.rdoc', 'MIT-LICENSE']
  spec.executables << 'cardigan'

  spec.add_dependency 'splat', '~>0.1.0'
  spec.add_dependency 'shell_shock', '~>0.0.1'
  spec.add_dependency 'uuidtools', '~>2.1.1'
  spec.add_dependency 'activesupport', '~>2.3.5'

  spec.add_development_dependency 'rake', '~>0.8.7'
  spec.add_development_dependency 'rspec', '~>1.3.0'
  spec.add_development_dependency 'orangutan', '~>0.0.7'
  spec.add_development_dependency 'gemesis', '~>0.0.3'
end