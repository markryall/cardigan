require 'cardigan/context'
require 'cardigan/text_report_formatter'

class Cardigan::Command::TotalCards
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    count_field, *grouping_fields = text.scan(/\w+/)
    counts = {}
    @repository.each do |card|
      key = grouping_fields.map {|grouping_field| card[grouping_field] ? card[grouping_field] : ''}
      value = card[count_field].to_i
      counts[key] = counts[key] ? counts[key] + value : value
    end

    values = counts.keys.sort.map do |key|
      hash = {count_field => counts[key]}
      grouping_fields.each_with_index {|grouping_field,index| hash[grouping_field] = key[index] }
      hash
    end

    formatter = Cardigan::TextReportFormatter.new @io
    grouping_fields.each {|grouping_field| formatter.add_column(grouping_field, 0)}
    formatter.add_column(count_field, 0)
    formatter.output values, :suppress_index => true
  end
end