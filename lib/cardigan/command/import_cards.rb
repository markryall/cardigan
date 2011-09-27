require 'cardigan/commands'
require 'csv'
require 'uuidtools'

class Cardigan::Command::ImportCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = '<filename>'
    @help = "Imports cards from the specific csv file.\nNote that if the file does not contain an id column, all new cards will be created.\nOtherwise, existing cards with a matching id will be updated."
  end

  def execute filename
    filename += ".csv"
    unless File.exist?(filename)
      @io.say "#{filename} does not exist"
      return
    end
    header, id_index = nil, nil
    CSV.open(filename, 'r') do |csv|
      csv.to_a.each do |row|
        if header
          if id_index and row[id_index]
            id = row[id_index]
            card = @repository[id] if @repository.exist?(id)
          end
          if card
            puts "updating #{id}"
          else
            id ||= UUIDTools::UUID.random_create.to_s
            card = {}
            puts "creating new card with id #{id}"
          end
          editor = Cardigan::CardEditor.new(card, @io)
          header.each_with_index do |field, index|
            editor.set field, row[index]
          end
          @repository[id] = card
        else
          header = row
          id_index = header.find_index('id')
        end
      end
    end
  end
end