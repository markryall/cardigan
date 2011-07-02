require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/total_cards'

describe Cardigan::Command::TotalCards do
  with_usage '<numeric field> <grouping field>*'
  with_help 'Calculates totals for the specified numeric field aggregated across the specified grouping fields'

  before do
    @repository, @prompt = stub(:repository), MockPrompt.new
    @command = Cardigan::Command::TotalCards.new @repository, @prompt
  end

  [nil, ''].each do |parameter|
    it "should count single row when called with #{parameter}" do
      @command.execute parameter
      @prompt.should have_received "missing required numeric total field"
    end
  end

  it 'should extract value for single row when no grouping fields are provided' do
    @repository.stub!(:cards).and_return [{'points' => '1'}]
    @command.execute "points"

    @prompt.messages.should == [
' --------',
'| points |',
' --------',
'| 1      |',
' --------'
]
  end

  it 'should generate total for multiple rows when no grouping fields are provided' do
    @repository.stub!(:cards).and_return [{'points' => '1'},{'points' => '2'}]
    @command.execute "points"

    @prompt.messages.should == [
' --------',
'| points |',
' --------',
'| 3      |',
' --------'
]
    end

  it 'should generate total for multiple rows when grouping fields are provided' do
    @repository.stub!(:cards).and_return [
      {'points' => '1', 'priority' => '1'},
      {'points' => '2', 'priority' => '2'},
      {'points' => '3', 'priority' => '1'}
    ]
    @command.execute "points priority"

    @prompt.messages.should == [
' -------------------',
'| priority | points |',
' -------------------',
'| 1        | 4      |',
'| 2        | 2      |',
' -------------------'
]
  end

  it 'should generate total for multiple rows when multiple grouping fields are provided' do
    @repository.stub!(:cards).and_return [
      {'points' => '1', 'priority' => '1', 'complexity' => '2'},
      {'points' => '2', 'priority' => '2', 'complexity' => '2'},
      {'points' => '3', 'priority' => '1', 'complexity' => '1'}
    ]
    @command.execute "points priority complexity"

    @prompt.messages.should == [
' --------------------------------',
'| priority | complexity | points |',
' --------------------------------',
'| 1        | 1          | 3      |',
'| 1        | 2          | 1      |',
'| 2        | 2          | 2      |',
' --------------------------------'
]
  end
end