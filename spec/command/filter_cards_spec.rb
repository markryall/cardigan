require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/filter_cards'

describe Cardigan::Command::FilterCards do
  with_usage '<ruby expression>'
  with_help "Sets the filter on cards to be displayed\nThis filter is a ruby expression that must return a boolean.\nBound variables are card (a hash) and me (a string)"

  before { @command = Cardigan::Command::FilterCards.new(nil,nil) }
end