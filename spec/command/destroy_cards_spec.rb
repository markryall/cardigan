require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/destroy_cards'

describe Cardigan::Command::DestroyCards do
  with_usage '<number>*'
  with_help 'Destroys the specified cards (by index in the list)'

  before { @command = Cardigan::Command::DestroyCards.new(nil,nil) }
end