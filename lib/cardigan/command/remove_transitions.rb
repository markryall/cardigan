class Cardigan::Command::RemoveTransitions
  def initialize entry
    @entry = entry
  end

  def execute text
    name, *states = text.scan(/\w+/)
    @entry[name] -= states
  end
end