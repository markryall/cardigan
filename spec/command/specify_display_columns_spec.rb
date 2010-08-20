require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/specify_display_columns'

describe Cardigan::Command::SpecifyDisplayColumns do
  extend CommandSpec
  with_usage '<column>*'
  with_help 'Specify the list of columns to display'

  before { @command = Cardigan::Command::SpecifyDisplayColumns.new(nil,nil) }
end