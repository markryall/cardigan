class Cardigan::Command::CreateStatus
  def initialize entry
    @entry = entry
  end

  def execute key
    @entry[key] ||= []
  end
end