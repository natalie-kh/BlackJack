require 'terminal-table'

class Interface
  attr_reader :game

  def initialize
    welcome_message
    @game = Game.new(new_user)
  end

  def new_user
    puts 'What is your name?'
    Player.new(gets.chomp)
  end

  def welcome_message
    puts 'BLACK JACK'
    puts 'Let\'s start'
  end

  def start
    game.new_round
    show_players_result

    user_action
    results
  end

  def user_choice
    puts 'Take additional card? y/n '
    gets.chomp
  end

  def user_action
    need_card = true
    while need_card
      case user_choice
      when 'y'
        game.dealer.deal_card(game.user)
        puts "#{game.user.name}: HIT"
        return results if game.bush? || game.black_jack?

        show_players_result(true)
      when 'n'
        puts "#{game.user.name}: STAND"
        need_card = false
      else
        user_action
      end
    end
    dealer_steps
  end

  def dealer_steps
    additional_cards_count = game.dealer.dealer_action
    additional_cards_count.times { puts 'Dealer: HIT' }
    puts 'Dealer: STAND' if game.dealer.total_value < 21
  end

  def show_players_result(is_hidden = true, has_title = false)
    rows = []
    rows << game.user.profile_array
    rows << game.dealer.profile_array(is_hidden)
    table = Terminal::Table.new headings: %w[Player Cards Total Balance]
    table.rows = rows
    table.title = has_title ? hand_result : "Bank: #{game.bank}"
    puts table
  end

  def hand_result
    message = if game.bush?
                'BUSH! '
              elsif game.black_jack?
                'BLACK JACK! '
              elsif game.push?
                'PUSH!'
              else
                ''
              end
    message += "#{game.winner.name} wins" if game.winner
    message
  end

  def continue?
    if game.money_limit?
      puts "GAME OVER. #{game_winner} wins! Start new game? y/n"
      game.players.each { |player| player.amount = 100 }
    else
      puts 'Continue? y/n'
    end
    gets.chomp == 'y' ? start : exit
  end

  def results
    game.finish_round
    show_players_result(false, true)
    continue?
  end

  def game_winner
    game.players.max_by(&:amount).name
  end
end
