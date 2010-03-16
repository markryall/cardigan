require 'csv'

class Cardigan::Command::ExportCards
  def initialize repository
    @repository = repository
  end

  def execute filename
    filename += ".csv"
    columns = @repository.columns
    CSV.open(filename, 'w') do |writer|
      writer << columns
      @repository.each do |card|
        writer << columns.map {|column| card[column] ? card[column] : ''}
      end
    end
  end
end