class Cardigan::Command::SpecifySortColumns
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    if text
      @repository.sort_columns = text.scan(/\w+/) 
    else
      @io.say "current columns: #{@repository.sort_columns.join(',')}"
      @io.say "available columns: #{@repository.columns.sort.join(',')}"
    end
  end
end