# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

puts 'What is your name?'
user_name = gets.chomp
dealer = Dealer.new(user_name)
dealer.start_round
