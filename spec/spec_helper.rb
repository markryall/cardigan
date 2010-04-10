$:.unshift File.dirname(__FILE__)+'/../lib'
require 'orangutan/mock_adapter'

module IoOutputReader
  def io_output
    out = StringIO.new
    calls.each {|call| out.puts call.args.first if call.name == :io and call.method == :say }
    out.string
  end
end