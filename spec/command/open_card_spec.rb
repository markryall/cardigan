require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/open_card'

describe Cardigan::Command::OpenCard do
  with_usage '<card name>'
  with_help 'Opens the specified card for editing'

  before { @command = Cardigan::Command::OpenCard.new(nil,nil,nil) }
end