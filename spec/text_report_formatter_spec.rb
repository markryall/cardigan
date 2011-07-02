require File.dirname(__FILE__)+'/spec_helper'
require 'cardigan/text_report_formatter'

describe Cardigan::TextReportFormatter do
  before do
    @formatter = Cardigan::TextReportFormatter.new(stub(:io))
  end

  it 'should write nothing with no columns or rows' do
    @formatter.output []
    calls.should == []
  end

  it 'should write a heading with a column but no rows' do
    @formatter.add_column 'foo', 10
    @formatter.output []
    io_output.should == <<EOF
 --------------------
| index | foo        |
 --------------------
 --------------------
EOF
  end

  it 'should write a heading with a column but no rows' do
    @formatter.add_column 'foo', 10
    @formatter.output [], :suppress_index => true
    io_output.should == <<EOF
 ------------
| foo        |
 ------------
 ------------
EOF
  end

  it 'should resize column according to size of heading' do
    @formatter.add_column 'foo', 0
    @formatter.output [], :suppress_index => true
    io_output.should == <<EOF
 -----
| foo |
 -----
 -----
EOF
  end
end