function randomWin(win_percent) {
  var winTotal = 0
  var gameTotal = 0

  while ( gameTotal < 7 ) {
    var win = Math.random() < win_percent;
    gameTotal++

    if (win && winTotal === 3) {
      winTotal = 4
      return [winTotal, gameTotal]
    } else if (win) {
        winTotal++
    }
  }

  return [winTotal, gameTotal]

}

console.log(randomWin(.60))

console.log(Math.random())