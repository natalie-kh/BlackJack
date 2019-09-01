# frozen_string_literal: true

class Card
  attr_reader :name, :suit, :value

  def initialize(name, suit)
    @name = name
    @suit = suit
    @value = get_value(name)
  end

  def get_value(name)
    if (2..10).include? name.to_i
      name.to_i
    elsif name == 'A'
      11
    else
      10
    end
  end

  def card_view
    "#{@suit}#{@name} "
  end
end
