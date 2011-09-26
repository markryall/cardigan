Gem::Specification.new do |spec|
  spec.name = 'cardigan'
  spec.version = '0.1.1'
  spec.summary = "command line utility for managing cards (tasks, bugs, stories or whatever)"
  spec.description = <<-EOF
A command line utility that manages cards as individual files so that they can be added to a version control system
EOF

  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/cardigan'
 
  spec.files = Dir['lib/**/*'] + Dir['bin/*'] + Dir['spec/**/*'] + ['README.rdoc', 'MIT-LICENSE', '.gemtest', 'Rakefile']
  spec.executables << 'cardigan'

  spec.required_ruby_version = '>= 1.9'

  spec.add_dependency 'flat_hash', '~>0'
  spec.add_dependency 'splat', '~>0'
  spec.add_dependency 'shell_shock', '~>0'
  spec.add_dependency 'uuidtools', '~>2'
  spec.add_dependency 'activesupport', '~>3'
  spec.add_dependency 'i18n', '~>0'

  spec.add_development_dependency 'rake', '~>0.8'
  spec.add_development_dependency 'rspec', '~>2'
  spec.add_development_dependency 'aruba', '~>0'
end