require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/add_transitions'

describe Cardigan::Command::AddTransitions do
  with_usage '<start status> [<subsequent status>]+'
  with_help 'Creates transitions from a starting status to a number of subsequent statuses'

  before do
    @entry = {}
    @io = MockPrompt.new
    @command = Cardigan::Command::AddTransitions.new @entry, @io
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

  it 'should append status when called with single' do
    @command.execute 'none started'
    @entry['none'].should == ['started']
  end

  it 'should ignore duplicate subsequent statuses' do
    @command.execute 'none started started'
    @entry['none'].should == ['started']
  end
end