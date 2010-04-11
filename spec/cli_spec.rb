require File.dirname(__FILE__)+'/spec_helper'
require 'cardigan/cli'

describe Cardigan::Cli do
  before do
    register_object :directory_class, Cardigan::Directory
    register_object :root_context_class, Cardigan::RootContext
    stub_method :directory_class, :new
    stub_method :root_context_class, :new
    so_when(:directory_class).receives(:new).with('.cards').return(stub(:cards_directory))
    so_when(:directory_class).receives(:new).with('~').return(stub(:home_directory))
    so_when(:root_context_class).receives(:new).return(stub(:root_context))
    so_when(:io, :as => :name_prompt).receives(:ask).with('Enter your full name').return('John Smith')
    so_when(:io, :as => :email_prompt).receives(:ask).with('Enter your email address').return('john@mail.com')
    @cli = Cardigan::Cli.new(stub(:io))
  end

  describe "when .cardigan file doesn't exist" do
    before do
      so_when(:home_directory, :as => :config_check).receives(:has_file?).with('.cardigan').return(false)
      so_when(:home_directory, :as => :store_config).receives(:store).with('.cardigan', {:name => 'John Smith',:email => 'john@mail.com'}).return({})
      @cli.execute
    end

    it 'should check for existance of config file' do
      expectation(:config_check).should be_matched
    end

    it 'should prompt for full name' do
      expectation(:name_prompt).should be_matched
    end

    it 'should prompt for email' do
      expectation(:email_prompt).should be_matched
    end
    
    it 'should write config hash' do
      expectation(:store_config).should be_matched
    end
  end
  
  describe "when .cardigan file does exist" do
    before do
      so_when(:home_directory, :as => :config_check).receives(:has_file?).with('.cardigan').return(true)
      so_when(:home_directory, :as => :load_config).receives(:load).with('.cardigan').return({})
      @cli.execute
    end

    it 'should check for existance of config file' do
      expectation(:config_check).should be_matched
    end

    it 'should not prompt for full name' do
      expectation(:name_prompt).should_not be_matched
    end

    it 'should not prompt for email' do
      expectation(:email_prompt).should_not be_matched
    end
    
    it 'should read config hash' do
      expectation(:load_config).should be_matched
    end
  end
end