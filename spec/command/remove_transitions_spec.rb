require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/remove_transitions'

describe Cardigan::Command::RemoveTransitions do
  with_usage '<start status> [<subsequent status>]+'
  with_help 'Removes transitions from a starting status to a number of subsequent statuses'

  before do
    @entry = {}
    @io = MockPrompt.new
    @command = Cardigan::Command::RemoveTransitions.new @entry, @io
  end

  [nil, ''].each do |parameter|
    it "should report error when called with #{parameter.inspect}" do
      @command.execute
      @io.should have_received "missing required start status"
    end
  end

  it 'should report error when called with a single parameter' do
    @command.execute 'none'
    @io.should have_received "missing required subsequent status"
  end
end