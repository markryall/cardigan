require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/total_cards'

describe Cardigan::Command::TotalCards do
  before do
    @command = Cardigan::Command::TotalCards.new(stub(:repository), stub(:io))
  end

  def output
    out = StringIO.new
    calls.each {|call| out.puts call.args.first if call.name == :io and call.method == :say }
    out.string
  end
  
  it 'should extract value for single row when no grouping fields are provided' do
    so_when(:repository).receives(:each).yield(
      {'points' => 1}
    )
    @command.execute "points"

    output.should == <<EOF
 --------
| points |
 --------
| 1      |
 --------
EOF
  end

  it 'should generate total for multiple rows when no grouping fields are provided' do
    so_when(:repository).receives(:each).yield('points' => 1).yield('points' => 2)
    @command.execute "points"

    output.should == <<EOF
 --------
| points |
 --------
| 3      |
 --------
EOF
    end

  it 'should generate total for multiple rows when grouping fields are provided' do
    expectation = so_when(:repository).receives(:each)
    expectation.yield('points' => 1, 'priority' => 1)
    expectation.yield('points' => 2, 'priority' => 2)
    expectation.yield('points' => 3, 'priority' => 1)
    @command.execute "points priority"

    output.should == <<EOF
 -------------------
| priority | points |
 -------------------
| 1        | 4      |
| 2        | 2      |
 -------------------
EOF
  end

  it 'should generate total for multiple rows when multiple grouping fields are provided' do
    expectation = so_when(:repository).receives(:each)
    expectation.yield('points' => 1, 'priority' => 1, 'complexity' => 2)
    expectation.yield('points' => 2, 'priority' => 2, 'complexity' => 2)
    expectation.yield('points' => 3, 'priority' => 1, 'complexity' => 1)
    @command.execute "points priority complexity"

    output.should == <<EOF
 --------------------------------
| priority | complexity | points |
 --------------------------------
| 1        | 1          | 3      |
| 1        | 2          | 1      |
| 2        | 2          | 2      |
 --------------------------------
EOF
  end
end