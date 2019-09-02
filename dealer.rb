# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Dealer < Player
  def initialize
    super('dealer')
  end

  # private

  def prepare_deck
    @deck = Deck.new
    shuffle
  end

  def shuffle(deck = @deck)
    deck.cards.shuffle!
  end

  def deal_card(user, deck = @deck)
    user.take_card(next_card(deck))
  end

  def next_card(deck = @deck)
    deck.cards.delete_at(0)
  end

  def dealer_action(deck = @deck)
    take_card(next_card(deck)) while total_value < 17
  end

  def initial_deal(users)
    2.times do
      users.each { |player| deal_card(player) }
    end
  end
end
