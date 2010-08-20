require 'cardigan/commands'

class Cardigan::Command::ShowEntry
  attr_reader :usage, :help

  def initialize entry, io
    @entry, @io = entry, io
    @usage = ''
    @help = 'Shows the entire content of the entry'
  end

  def execute ignored=nil
    @entry.keys.sort.each { |key| @io.say "#{key}: #{@entry[key].inspect}" }
  end
end