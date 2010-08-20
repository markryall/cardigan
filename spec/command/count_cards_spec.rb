require File.dirname(__FILE__)+'/../spec_helper'
require 'cardigan/command/count_cards'

describe Cardigan::Command::CountCards do
  include IoOutputReader
  extend CommandSpec
  with_usage '<grouping field>*'
  with_help 'Counts cards aggregated across the specified grouping fields'

  before do
    @command = Cardigan::Command::CountCards.new(stub(:repository), stub(:io))
  end

  [nil, ''].each do |parameter|
    it "should count single row when called with #{parameter}" do
      so_when(:repository).receives(:cards).return([])
      @command.execute parameter

      io_output.should == <<EOF
 -------
| count |
 -------
| 0     |
 -------
EOF
    end
  end

  it 'should count single row when no grouping fields are provided' do
    so_when(:repository).receives(:cards).return([{'points' => 1}])
    @command.execute

    io_output.should == <<EOF
 -------
| count |
 -------
| 1     |
 -------
EOF
  end

  it 'should count single row when a single grouping fields are provided' do
    so_when(:repository).receives(:cards).return([{'type' => 'bug'}])
    @command.execute 'type'

    io_output.should == <<EOF
 --------------
| type | count |
 --------------
| bug  | 1     |
 --------------
EOF
  end

  it 'should count single row when a single grouping fields are provided' do
    so_when(:repository).receives(:cards).return([{'type' => 'bug'},{'type' => 'feature'}])
    @command.execute 'type'

    io_output.should == <<EOF
 -----------------
| type    | count |
 -----------------
| bug     | 1     |
| feature | 1     |
|         | 2     |
 -----------------
EOF
  end
end