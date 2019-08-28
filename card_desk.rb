require_relative 'card'
class CardDesk
  attr_reader :cards

  def initialize
    @cards = create_desk
  end

  def create_desk
    card_desk = []
    suites = %w[♠ ♥ ♣ ♦]
    names = %w[J Q K A] + (2..10).to_a
    names.map do |name|
      suites.each do |suite|
        card_desk << Card.new(name, suite)
      end
    end
    card_desk
  end

  def deal_card
    @cards.sample
  end

  private

  def delete_cards(*cards)
    cards.each { |card| @cards.delete(card) }
  end
end
