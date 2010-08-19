require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/claim_cards'

describe Cardigan::Command::ClaimCards do
  before do
    @command = Cardigan::Command::ClaimCards.new(nil,nil,nil)
  end

  it 'should display usage' do
    @command.usage.should == '<number> [<number]*'
  end

  it 'should display help' do
    @command.help.should == 'Sets you as the owner of the specified cards'
  end
end