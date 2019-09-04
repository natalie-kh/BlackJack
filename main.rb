require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'
require_relative 'interface'

class Main
  attr_reader :interface
  def initialize
    @interface = Interface.new
  end
end

int = Main.new
int.interface.start
