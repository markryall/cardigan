require 'cardigan/commands'

class Cardigan::Command::CommitChanges
  attr_reader :usage, :help

  def initialize repository, io
    @io, @repository = io, repository
    @usage = "<commit message>"
    @help = "Commits _all_ changes (adds, removes and modifications) to the source control system\nWarning: Use with caution. This will not only commit changes to cards - all modifications will be committed."
  end

  def execute text=nil
    @repository.addremovecommit text
  end
end