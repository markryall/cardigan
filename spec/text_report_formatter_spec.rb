require File.dirname(__FILE__)+'/spec_helper'
require 'cardigan/text_report_formatter'

describe Cardigan::TextReportFormatter do
  before do
    @io = MockPrompt.new
    @formatter = Cardigan::TextReportFormatter.new @io
  end

  it 'should write nothing with no columns or rows' do
    @formatter.output []
    @io.messages.should be_empty
  end

  it 'should write a heading with a column but no rows' do
    @formatter.add_column 'foo', 10
    @formatter.output []
    @io.messages.should.should == [
' --------------------',
'| index | foo        |',
' --------------------',
' --------------------'
]
  end

  it 'should write a heading with a column but no rows' do
    @formatter.add_column 'foo', 10
    @formatter.output [], :suppress_index => true
    @io.messages.should.should == [
' ------------',
'| foo        |',
' ------------',
' ------------'
]
  end

  it 'should resize column according to size of heading' do
    @formatter.add_column 'foo', 0
    @formatter.output [], :suppress_index => true
    @io.messages.should.should == [
' -----',
'| foo |',
' -----',
' -----'
]
  end
end