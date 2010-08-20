require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/claim_cards'

describe Cardigan::Command::ClaimCards do
  extend CommandSpec
  with_usage '<number>*'
  with_help 'Sets you as the owner of the specified cards (by index in the list)'

  before { @command = Cardigan::Command::ClaimCards.new(nil,nil,nil) }
end