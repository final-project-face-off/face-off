def randomWin(team1_win_percent)
  winTotal = 0
  loseTotal = 0
  gameTotal = 0

  while gameTotal < 7 do
    win = Random.rand() < team1_win_percent
    gameTotal += 1
    if win
      winTotal += 1
    else
      loseTotal +=1
    end
    break if winTotal == 4 || loseTotal == 4
  end

  { wins: winTotal, losses: loseTotal, games: gameTotal }

end

puts randomWin(0.5)
