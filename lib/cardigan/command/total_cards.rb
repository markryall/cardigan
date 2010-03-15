class Cardigan::Command::TotalCards
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    count_field, *grouping_fields = text.scan(/\w+/)
    counts = {}
    @repository.cards.each do |card|
      key = grouping_fields.map {|key| card[key] ? card[key] : ''}
      value = card[count_field].to_i
      counts[key] = counts[key] ? counts[key] + value : value
    end
    counts.keys.sort.each {|key| @io.say "#{counts[key]} #{key.inspect}"}
  end
end