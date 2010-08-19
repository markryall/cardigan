require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/open_card'

describe Cardigan::Command::OpenCard do
  before do
    @command = Cardigan::Command::OpenCard.new(nil,nil,nil)
  end

  it 'should display usage' do
    @command.usage.should == '<card name>'
  end

  it 'should display help' do
    @command.help.should == 'Opens the specified card for editing'
  end
end