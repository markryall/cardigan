class Cardigan::Command::CountCards
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    grouping_fields = text.scan(/\w+/)
    counts = {}
    @repository.cards.each do |card|
      key = grouping_fields.map {|key| card[key] ? card[key] : ''}
      counts[key] = counts[key] ? counts[key] + 1 : 1
    end
    counts.keys.sort.each {|key| @io.say "#{counts[key]} #{key.inspect}"}
  end
end