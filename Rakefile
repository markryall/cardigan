require 'bundler/gem_tasks'

task :default => :test

desc 'execute specifications'
task :test do
  sh 'rspec spec'
end

desc 'execute features'
task :features do
  sh 'cucumber'
end

task :all => [:test, :features]

SHARED_DOCS=%w{README HISTORY}

desc "Push feature documentation to relishapp using the relish-client-gem"
task :relish, :version do |t, args|
  raise "rake relish[VERSION]" unless args[:version]
  SHARED_DOCS.each {|doc| sh "cp #{doc}.md features/" }
  sh "relish push cardigan/cardigan:#{args[:version]}"
  SHARED_DOCS.each {|doc| sh "rm features/#{doc}.md" }
end
