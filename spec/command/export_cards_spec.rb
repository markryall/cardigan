require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/export_cards'

describe Cardigan::Command::ExportCards do
  extend CommandSpec
  with_usage '<filename>'
  with_help 'Exports all cards according to the current filter'

  before { @command = Cardigan::Command::ExportCards.new(nil) }
end