class Cardigan::Command::SpecifyDisplayColumns
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    if text
      @repository.display_columns = text.scan(/\w+/) 
    else
      @io.say "current columns: #{@repository.display_columns.join(',')}"
      @io.say "available columns: #{@repository.columns.sort.join(',')}"
    end
  end
end