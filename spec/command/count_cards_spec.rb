require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/count_cards'

describe Cardigan::Command::CountCards do
  with_usage '<grouping field>*'
  with_help 'Counts cards aggregated across the specified grouping fields'

  before do
    @repository, @prompt = stub(:repository), MockPrompt.new
    @command = Cardigan::Command::CountCards.new @repository, @prompt
  end

  [nil, ''].each do |parameter|
    it "should count single row when called with #{parameter}" do
      @repository.stub!(:cards).and_return []
      @command.execute parameter

      @prompt.messages.should.should == [
' -------',
'| count |',
' -------',
'| 0     |',
' -------'
]
    end
  end

  it 'should count single row when no grouping fields are provided' do
    @repository.stub!(:cards).and_return [{'points' => 1}]
    @command.execute

    @prompt.messages.should.should == [
' -------',
'| count |',
' -------',
'| 1     |',
' -------'
]
  end

  it 'should count single row when a single grouping fields are provided' do
    @repository.stub!(:cards).and_return [{'type' => 'bug'}]
    @command.execute 'type'

    @prompt.messages.should.should == [
' --------------',
'| type | count |',
' --------------',
'| bug  | 1     |',
' --------------'
]
  end

  it 'should count single row when a single grouping fields are provided' do
    @repository.stub!(:cards).and_return [{'type' => 'bug'},{'type' => 'feature'}]
    @command.execute 'type'

    @prompt.messages.should.should == [
' -----------------',
'| type    | count |',
' -----------------',
'| bug     | 1     |',
'| feature | 1     |',
'|         | 2     |',
' -----------------'
]
  end
end