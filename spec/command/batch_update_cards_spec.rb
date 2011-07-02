require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/batch_update_cards'

describe Cardigan::Command::BatchUpdateCards do
  with_usage '<field> <number>*'
  with_help 'Sets the specified field to a new value for the specified cards (by index in the list)'

  before { @command = Cardigan::Command::BatchUpdateCards.new(nil,nil) }
end