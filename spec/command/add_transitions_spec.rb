require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/add_transitions'

describe Cardigan::Command::AddTransitions do
  include IoOutputReader

  before do
    @entry = {}
    @command = Cardigan::Command::AddTransitions.new(@entry, stub(:io))
  end

  [nil, ''].each do |parameter|
    it "should report error when called with #{parameter.inspect}" do
      @command.execute
      io_output.should == "missing required start status\n"
    end
  end

  it 'should report error when called with a single parameter' do
    @command.execute 'none'
    io_output.should == "missing required subsequent status\n"
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