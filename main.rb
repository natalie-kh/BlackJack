require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'

class Main
  def initialize
    puts 'BLACK JACK'
    puts 'Lets start! What is your name?'
    user_name = gets.chomp
    Game.new(user_name).new_round
  end
end

Main.new
