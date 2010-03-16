require 'csv'

class Cardigan::Command::ImportCards
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute filename
    filename += ".csv"
    unless File.exist?(filename)
      @io.say "#{filename} does not exist"
      return
    end
    header, id_index = nil, nil
    CSV.open(filename, 'r') do |row|
      if header
        card = @repository.load(row[id_index]) if id_index and row[id_index]
        @io.say card ? "updating #{card['id']}" : "creating new card"
        card = @repository.create unless card
        editor = Cardigan::CardEditor.new(card, @io)
        header.each_with_index do |field, index|
          editor.set field, row[index]
        end
        @repository.save card
      else
        header = row
        id_index = header.find_index('id')
      end
    end
  end
end