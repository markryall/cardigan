require File.dirname(__FILE__)+'/spec_helper'
require 'cardigan/workflow_repository'

describe Cardigan::WorkflowRepository do
  before do
    @directory = stub 'directory'
    @serialiser = stub 'serialiser'
    @path = stub 'path'
    FlatHash::Directory.stub!(:new).and_return @directory
    FlatHash::Serialiser.stub!(:new).and_return @serialiser
  end

  describe '#construction' do
    it 'should create a directory at the specified path' do
      FlatHash::Directory.should_receive(:new).with(@serialiser, @path).and_return @directory
      Cardigan::WorkflowRepository.new @path
    end
  end

  describe '#load' do
    before do
      @repository = Cardigan::WorkflowRepository.new @path
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
