class Player
  attr_reader :name, :amount, :cards

  def initialize(name, amount = 100)
    @name = name
    @amount = amount
    @cards = []
  end

  def take_two_cards(card1, card2)
    raise 'No more than three cards' if @cards.size > 1
    @cards.push(card1, card2)
  end

  def take_additional_card(card)
    raise 'No more than three cards' if @cards.size > 2
    @cards << card
  end

  def make_bet(bet = 10)
    raise 'Not enough money' if @amount < bet
    @amount -= bet
  end

  def total_value
    a_count = @cards.count { |card| card.name == 'A' }
    sum = @cards.each.sum { |card| card.value }
    if sum > 21 && a_count != 0
      values = (0..a_count).map { |count| sum - count * 10}
      sum = values.select { |val| (0..21).include? val }.max
    end
    sum
  end

  def take_bank(bank)
    @amount += bank
  end

  def open_cards
    @cards.each { |card| print card.card_view }
  end


end