# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Dealer < Player
  INITIAL_BET = 10

  def initialize(user_name)
    super('dealer')
    @bank = 0
    @player = Player.new(user_name)
  end

  def start_round(user = @player)
    @deck = Deck.new
    shuffle
    initial_bet(user)
    [self, user].each { |player| player.cards = [] }
    initial_deal(user)
    players_result('hidden')
    finish_round if auto_finish?
    ask_user(user)
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
    finish_round
  end

  def ask_user(user = @player)
    need_card = true
    while need_card
      puts "Your turn: 'h' - hit, 's' - stand"
      case gets.chomp
      when 'h'
        deal_card(user)
        return finish_round if auto_finish?

        players_result('hidden', user)
      when 's'
        puts "#{user.name.capitalize}: Stand"
        need_card = false
      end
    end
    dealer_action
  end

  def initial_deal(user)
    2.times do
      [user, self].each { |player| deal_card(player) }
    end
  end

  def initial_bet(user, amount = INITIAL_BET)
    [user, self].each { |player| player.make_bet(amount) }
    @bank = amount * 2
  end

  def players_result(hidden = nil, user = @player)
    user.view_cards
    view_cards(hidden)
  end

  def auto_finish?
    @player.total_value >= 21
  end

  def winner(user = @player)
    users = [user, self].select { |player| player.total_value < 22 }
    case users.size
    when 1
      users[0]
    when 2
      if users[0].total_value > users[1].total_value
        users[0]
      elsif users[0].total_value < users[1].total_value
        users[1]
      end
    else
      raise 'Wrong users array'
    end
  end

  def finish_round
    hand_result
    players_result
    winner.nil? ? (puts 'PUSH') : (puts "#{winner.name.capitalize} wins")
    continue?
  end

  def hand_result(user = @player)
    if winner.nil?
      [user, self].each { |player| player.take_bank(@bank / 2) }
    else
      winner.take_bank(@bank)
    end
  end

  def continue?(user = @player)
    if user.amount < INITIAL_BET
      puts 'No enough money. Start new game?'
      [user, self].each { |player| player.amount = 100 }
    else
      puts 'Continue? y/n'
    end
    gets.chomp == 'y' ? start_round : exit
  end
end
