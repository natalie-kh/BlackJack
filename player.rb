class Player
  attr_accessor :name, :amount, :cards

  def initialize(name, amount = 100)
    @name = name.capitalize!
    @amount = amount
    @cards = []
  end

  def take_card(card)
    @cards << card
  end

  def discard
    @cards = []
  end

  def make_bet(bet)
    raise 'Not enough money' if @amount < bet

    @amount -= bet
  end

  def total_value(is_hidden = false)
    ace_count = @cards.count { |card| card.name == 'A' }
    sum = @cards.each.sum(&:value)

    if sum > 21 && ace_count.positive?
      values = (0..ace_count).map { |count| sum - count * 10 }
      sum = values.select { |val| (0..21).cover? val }.max
      sum ||= values.min
    end
    is_hidden ? @cards.last.value : sum
  end

  def take_bank(bank)
    @amount += bank
  end

  def show_cards(is_hidden = false)
    if is_hidden
      '** ' * (@cards.size - 1) + @cards.last.card_view
    else
      @cards.map(&:card_view).join
    end
  end

  def profile_array(is_hidden = false)
    [name, show_cards(is_hidden), total_value(is_hidden), @amount]
  end
end
