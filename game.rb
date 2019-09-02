# frozen_string_literal: true

require_relative 'helpers/with_black_jack_rules'

class Game
  include WithBlackJackRules
  INITIAL_BET = 10

  # think abour remove attr
  attr_accessor :player, :dealer, :bank, :players

  def initialize(user_name)
    @player = Player.new(user_name)
    @dealer = Dealer.new
    @players = [@player, @dealer]
  end

  def new_round
    @bank = 0
    @players.each(&:discard)
    @dealer.prepare_deck

    initial_bet
    @dealer.initial_deal(@players)
    show_players_result
    finish_round if black_jack?

    ask_user(@player)
    @dealer.dealer_action
    finish_round
  end

  private

  def initial_bet
    @players.each { |player| player.make_bet(INITIAL_BET) }
    @bank = INITIAL_BET * 2
  end

  def show_players_result(is_hidden = true)
    @player.profile
    @dealer.profile(is_hidden)
  end

  def finish_round
    give_bank
    show_players_result(false)
    puts hand_result
    continue?
  end

  def continue?
    if @player.amount < INITIAL_BET
      puts 'No enough money. Start new game?'
      @players.each { |player| player.amount = 100 }
    else
      puts 'Continue? y/n'
    end
    gets.chomp == 'y' ? new_round : exit
  end

  def ask_user(user = @player)
    is_need_card = true
    while is_need_card
      puts "Your turn: 'h' - hit, 's' - stand"
      case gets.chomp
        when 'h'
          @dealer.deal_card(user)
          return finish_round if bush? || black_jack?

          show_players_result
        when 's'
          puts "#{user.name.capitalize}: Stand"
          is_need_card = false
        else
          puts 'Incorrect command, please use s or h!'
      end
    end
  end

  def hand_result
    message = "#{winner.name.capitalize} wins" if winner
    if bush?
      'BUSH! ' + message
    elsif black_jack?
      'BLACK JACK! ' + message
    elsif push?
      'PUSH!'
    else
      message
    end
  end
end
