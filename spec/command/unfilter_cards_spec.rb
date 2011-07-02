require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/unfilter_cards'

describe Cardigan::Command::UnfilterCards do
  with_usage ''
  with_help 'Removes the current filter (or does nothing if no filter has been specified)'

  before { @command = Cardigan::Command::UnfilterCards.new(nil,nil) }
end