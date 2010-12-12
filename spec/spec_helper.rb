$:.unshift File.dirname(__FILE__)+'/../lib'

Gem::Specification.load(File.dirname(__FILE__)+'/../gemspec').dependencies.each do |dep|
  gem dep.name, dep.requirement
end

require 'orangutan/mock_adapter'

require 'stringio'

module IoOutputReader
  def io_output
    out = StringIO.new
    calls.each {|call| out.puts call.args.first if call.name == :io and call.method == :say }
    out.string
  end
end

module CommandSpec
  def with_usage text
    it('should display usage') { @command.usage.should == text }
  end

  def with_help text
    it('should display help') { @command.help.should == text }
  end
end