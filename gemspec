Gem::Specification.new do |spec|
  spec.name = 'cardigan'
  spec.version = '0.0.9'
  spec.summary = "command line utility for managing cards (tasks, bugs, stories or whatever)"
  spec.description = <<-EOF
A command line utility that manages cards as individual files so that they can be added to a version control system
EOF

  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/cardigan'
 
  spec.files = Dir['lib/**/*'] + Dir['bin/*'] + ['README.rdoc', 'MIT-LICENSE']
  spec.executables << 'cardigan'

  spec.add_dependency 'uuidtools', ['~>2.1.1']
  spec.add_dependency 'activesupport', ['~>2.3.5']
end
