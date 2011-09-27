require 'cardigan/commands'
require 'cardigan/text_report_formatter'

class Cardigan::Command::CountCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = "<grouping field>*"
    @help = "Counts cards aggregated across the specified grouping fields"
  end

  def execute text=nil
    text = '' unless text
    grouping_fields = text.scan(/\w+/)
    lengths = Array.new(grouping_fields.size, 0)
    counts = {}
    total = 0
    @repository.cards.each do |card|
      grouping_fields.each_with_index do |grouping_field,index|
        lengths[index] = card[grouping_field].size if card[grouping_field] and card[grouping_field].size > lengths[index]
      end
      key = grouping_fields.map {|key| card[key] ? card[key] : ''}
      counts[key] = counts[key] ? counts[key] + 1 : 1
      total += 1
    end

    values = counts.keys.sort.map do |key|
      hash = {'count' => counts[key]}
      grouping_fields.each_with_index {|grouping_field,index| hash[grouping_field] = key[index] }
      hash
    end

    values << {'count' => total} unless counts.size == 1

    formatter = Cardigan::TextReportFormatter.new @io
    grouping_fields.each_with_index {|grouping_field,index| formatter.add_column(grouping_field, lengths[index])}
    formatter.add_column('count', 0)
    formatter.output values, :suppress_index => true
  end
end