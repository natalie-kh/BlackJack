module WithBlackJackRules
  def bush?
    player.total_value > 21
  end

  def black_jack?
    player.total_value == 21
  end

  def push?
    dealer.total_value == player.total_value
  end

  def winner
    users = players.select { |player| player.total_value < 22 }
    case users.size
    when 1
      users[0]
    when 2
      max_total = users.max_by(&:total_value).total_value
      users = users.select { |player| player.total_value == max_total }
      users.size == 2 ? nil : users[0]
    else
      raise 'Wrong users array'
    end
  end

  def give_bank
    if push?
      players.each { |player| player.take_bank(bank / 2) }
    else
      winner.take_bank(bank)
    end
  end
end
