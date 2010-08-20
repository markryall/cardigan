require 'cardigan/commands'

class Cardigan::Command::RemoveTransitions
  attr_reader :usage, :help

  def initialize entry, io
    @entry, @io = entry, io
    @usage = '<start status> [<subsequent status>]+'
    @help = 'Removes transitions from a starting status to a number of subsequent statuses'
  end

  def execute text=nil
    unless text and !text.empty?
      @io.say 'missing required start status'
      return
    end
    name, *states = text.scan(/\w+/)
    if states.empty?
      @io.say 'missing required subsequent status'
      return
    end
    name, *states = text.scan(/\w+/)
    @entry[name] -= states
  end
end