require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/specify_sort_columns'

describe Cardigan::Command::SpecifySortColumns do
  extend CommandSpec
  with_usage '<column>*'
  with_help 'Specify the list of columns to sort by'

  before { @command = Cardigan::Command::SpecifySortColumns.new(nil,nil) }
end