require File.dirname(__FILE__)+'/spec_helper'
require 'cardigan/workflow_repository'

describe Cardigan::WorkflowRepository do
  before do
    @directory = stub 'directory'
  end

  describe '#load' do
    before do
      @repository = Cardigan::WorkflowRepository.new @directory
    end

    it 'should return empty hash when repository does not contain an entry with the workflow key' do
      @directory.should_receive(:exist?).with('.card_workflow').and_return false
      @repository.load.should == {}
    end

    it 'should return populated hash when repository contains an entry with the workflow key' do
      @directory.should_receive(:exist?).with('.card_workflow').and_return true
      @directory.should_receive(:[]).with('.card_workflow').and_return 'first' => [], 'second' => []
      @repository.load.should == {'first' => [], 'second' => []}
    end
  end
end
