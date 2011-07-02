require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/commit_changes'

describe Cardigan::Command::CommitChanges do
  with_usage '<commit message>'
  with_help "Commits _all_ changes (adds, removes and modifications) to the source control system\nWarning: Use with caution. This will not only commit changes to cards - all modifications will be committed."

  before { @command = Cardigan::Command::CommitChanges.new(nil,nil) }
end