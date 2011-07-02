$:.unshift File.dirname(__FILE__)+'/../lib'

class MockPrompt
  def initialize
    @said = []
  end

  def say message
    @said << message
  end

  def has_received? message
    @said.include? message
  end

  def messages
    @said
  end
end

require 'shell_shock/command_spec'

RSpec.configure do |config|
  config.extend ShellShock::CommandSpec
end