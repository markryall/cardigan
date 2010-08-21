require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/change_value'

describe Cardigan::Command::ChangeValue do
  extend CommandSpec
  with_usage '<key>'
  with_help 'Prompt for a new value to associate with the specified key'

  before { @command = Cardigan::Command::ChangeValue.new(nil,nil) }
end