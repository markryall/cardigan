require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/create_card'

describe Cardigan::Command::CreateCard do
  with_usage '<name>'
  with_help 'Creates a new card with the specified name (without opening it for editing)'

  before { @command = Cardigan::Command::CreateCard.new(nil) }
end