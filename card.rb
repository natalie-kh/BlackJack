class Card
  attr_reader :name, :suit, :value

  def initialize(name, suit, value)
    @name = name
    @suit = suit
    @value = value
  end

  def card_view
    "#{@suit}#{@name} "
  end

  def ace?
    name == 'A'
  end
end
