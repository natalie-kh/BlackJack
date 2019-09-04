require_relative 'helpers/with_black_jack_rules'

class Game
  include WithBlackJackRules
  INITIAL_BET = 10

  attr_reader :user, :dealer, :bank, :players

  def initialize(user)
    @user = user
    @dealer = Dealer.new
    @players = [@user, @dealer]
  end

  def new_round
    @bank = 0
    @players.each(&:discard)
    @dealer.prepare_deck

    initial_bet
    @dealer.initial_deal(@players)
  end

  def initial_bet
    @players.each { |player| player.make_bet(INITIAL_BET) }
    @bank = INITIAL_BET * 2
  end

  def finish_round
    give_bank
  end

  def money_limit?
    @players.any? { |player| player.amount < INITIAL_BET }
  end
end
