require_relative 'card'
class Deck
  SUITES = %w[♠ ♥ ♣ ♦].freeze
  NAMES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    card_deck = []
    SUITES.map do |suite|
      NAMES.each_with_index do |name, index|
        card_deck << Card.new(name, suite, VALUES[index])
      end
    end
    card_deck
  end
end
