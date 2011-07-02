require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/edit_value'

describe Cardigan::Command::EditValue do
  with_usage '<key>'
  with_help 'Launch default editor to specify a new value to associate with the specified key'

  before { @command = Cardigan::Command::EditValue.new(nil,nil) }
end