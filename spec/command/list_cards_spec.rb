require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/list_cards'

describe Cardigan::Command::ListCards do
  extend CommandSpec
  with_usage ''
  with_help 'Lists all cards that match the current filter'

  before { @command = Cardigan::Command::ListCards.new(nil,nil) }
end