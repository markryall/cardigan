module Cardigan
  class WorkflowRepository
    def initialize path
      @directory = Directory.new(path)
      @path = '.card_workflow'
    end

    def save workflow
      @directory.store @path, workflow
    end
    
    def load
      @directory.has_file?(@path) ? @directory.load(@path) : {}
    end
  end
end