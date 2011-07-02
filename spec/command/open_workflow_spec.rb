require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/open_workflow'

describe Cardigan::Command::OpenWorkflow do
  with_usage ''
  with_help 'Opens the current workflow for editing'

  before { @command = Cardigan::Command::OpenWorkflow.new(nil,nil) }
end