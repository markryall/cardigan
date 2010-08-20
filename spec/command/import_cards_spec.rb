require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/import_cards'

describe Cardigan::Command::ImportCards do
  extend CommandSpec
  with_usage '<filename>'
  with_help "Imports cards from the specific csv file.\nNote that if the file does not contain an id column, all new cards will be created.\nOtherwise, existing cards with a matching id will be updated."

  before { @command = Cardigan::Command::ImportCards.new(nil,nil) }
end