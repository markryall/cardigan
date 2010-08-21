require 'cardigan/commands'
require 'splat'
require 'cardigan/card_editor'

class Cardigan::Command::EditValue
  attr_reader :usage, :help

  def initialize entry, io
    @entry, @io = entry, io
    @usage = '<key>'
    @help = 'Launch default editor to specify a new value to associate with the specified key'
  end

  def execute key
    value = @entry[key] ? @entry[key] : ''
    Cardigan::CardEditor.new(@entry, @io).set key, value.to_editor
  end
end