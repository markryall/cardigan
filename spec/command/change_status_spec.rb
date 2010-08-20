require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/change_status'

describe Cardigan::Command::ChangeStatus do
  extend CommandSpec
  with_usage '<new status>'
  with_help 'Changes the status of the current entry'

  before { @command = Cardigan::Command::ChangeStatus.new(nil,nil) }
end