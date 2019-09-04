require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Dealer < Player
  def initialize
    super('dealer')
  end

  def prepare_deck
    @deck = Deck.new
    shuffle
  end

  def deal_card(user, deck = @deck)
    user.take_card(next_card(deck))
  end

  def dealer_action(deck = @deck)
    while total_value < 17
      take_card(next_card(deck))
      puts 'Dealer: HIT'
    end
    puts 'Dealer: STAND' if total_value <= 22
  end

  def initial_deal(users)
    2.times do
      users.each { |player| deal_card(player) }
    end
  end

  private

  def next_card(deck = @deck)
    deck.cards.delete_at(0)
  end

  def shuffle(deck = @deck)
    deck.cards.shuffle!
  end
end
