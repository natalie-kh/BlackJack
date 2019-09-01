# frozen_string_literal: true

require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    card_deck = []
    suites = %w[♠ ♥ ♣ ♦]
    names = %w[J Q K A] + (2..10).to_a
    names.map do |name|
      suites.each do |suite|
        card_deck << Card.new(name, suite)
      end
    end
    card_deck
  end
end
