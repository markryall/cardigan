require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/show_entry'

describe Cardigan::Command::ShowEntry do
  with_usage ''
  with_help 'Shows the entire content of the entry'

  before { @command = Cardigan::Command::ShowEntry.new(nil, nil) }
end