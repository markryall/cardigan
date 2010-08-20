require 'cardigan/commands'

class Cardigan::Command::AddTransitions
  attr_reader :usage, :help

  def initialize entry, io
    @entry, @io = entry, io
    @usage = '<start status> [<subsequent status>]+'
    @help = 'Creates transitions from a starting status to a number of subsequent statuses'
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
    @entry[name] ||= []
    states = states.uniq
    @entry[name] += states
    states.each {|state| @entry[state] ||= [] }
  end
end