begin
  require 'gemesis/rake'
rescue Exception
  puts "gemesis related tasks will only be available if you 'gem install gemesis'"
end

desc 'execute specifications'
task :test do
  sh 'rspec spec'
end