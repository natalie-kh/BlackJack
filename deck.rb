require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    card_deck = []
    Card::SUITES.map do |suite|
      Card::NAMES.each_with_index do |name, index|
        card_deck << Card.new(name, suite, Card::VALUES[index])
      end
    end
    card_deck
  end
end
