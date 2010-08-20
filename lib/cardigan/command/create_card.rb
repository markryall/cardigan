require 'cardigan/commands'
require 'uuidtools'

class Cardigan::Command::CreateCard
  attr_reader :usage, :help

  def initialize repository
    @repository = repository
    @usage = '<name>'
    @help = 'Creates a new card with the specified name (without opening it for editing)'
  end

  def execute name
    @repository[UUIDTools::UUID.random_create.to_s] = {'name' => name }
  end
end 