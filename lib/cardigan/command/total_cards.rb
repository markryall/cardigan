require 'cardigan/commands'
require 'cardigan/text_report_formatter'

class Cardigan::Command::TotalCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = '<numeric field> <grouping field>*'
    @help = 'Calculates totals for the specified numeric field aggregated across the specified grouping fields'
  end

  def execute text=nil    
    count_field, *grouping_fields = text.scan(/\w+/) if text
    unless count_field
      @io.say 'missing required numeric total field'
      return
    end
    counts = {}
    total = 0
    @repository.cards.each do |card|
      key = grouping_fields.map {|grouping_field| card[grouping_field] ? card[grouping_field] : ''}
      value = card[count_field].to_i
      counts[key] = counts[key] ? counts[key] + value : value
      total += value
    end

    values = counts.keys.sort.map do |key|
      hash = {count_field => counts[key]}
      grouping_fields.each_with_index {|grouping_field,index| hash[grouping_field] = key[index] }
      hash
    end

    values << {count_field => total} unless counts.size == 1

    formatter = Cardigan::TextReportFormatter.new @io
    grouping_fields.each {|grouping_field| formatter.add_column(grouping_field, 0)}
    formatter.add_column(count_field, 0)
    formatter.output values, :suppress_index => true
  end
end