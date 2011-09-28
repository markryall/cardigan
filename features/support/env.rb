require 'aruba/cucumber'
require 'fileutils'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

HOME = File.expand_path '~'
CARDIGAN_CONFIG = HOME+'/.cardigan'
CARDIGAN_CONFIG_BKP = CARDIGAN_CONFIG+'.bkp'
CARDIGAN_NAME = 'Ms Crazy Person'
CARDIGAN_EMAIL = 'you@there.com'

Before do
  FileUtils.mv CARDIGAN_CONFIG, CARDIGAN_CONFIG_BKP if File.exist? CARDIGAN_CONFIG
  File.open CARDIGAN_CONFIG, 'w' do |file|
      file.puts <<EOF
email
#{CARDIGAN_EMAIL}
<----->
name
#{CARDIGAN_NAME}
EOF
  end
end

After do
  FileUtils.rm CARDIGAN_CONFIG
  FileUtils.mv CARDIGAN_CONFIG_BKP, CARDIGAN_CONFIG if File.exist? CARDIGAN_CONFIG_BKP
end