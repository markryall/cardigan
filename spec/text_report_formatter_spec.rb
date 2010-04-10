require File.dirname(__FILE__)+'/spec_helper'

describe Cardigan::TextReportFormatter do
  before do
    @formatter = Cardigan::TextReportFormatter.new(stub(:io))
  end

  it 'should write nothing with no columns or rows' do
    @formatter.output []
    calls.should == []
  end

  def output
    out = StringIO.new
    calls.each {|call| out.puts(call.args.first)}
    out.string
  end

  it 'should write a heading with a column but no rows' do
    @formatter.add_column 'foo', 10
    @formatter.output []
    output.should == <<EOF
 ---------------------
| index |  foo        |
 ---------------------
 ---------------------
EOF
  end

    it 'should write a heading with a column but no rows' do
      @formatter.add_column 'foo', 10
      @formatter.output [], :suppress_index => true
      output.should == <<EOF
 -------------
|  foo        |
 -------------
 -------------
EOF
    end
end