class Card
  SUITES = %w[♠ ♥ ♣ ♦].freeze
  NAMES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

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
