import RegexBuilder

func day06Part1(input: String) -> Int {
  let rows = input.lines()
  let raceData = zip(rows[0].matches(of: regex).map(\.output.1), rows[1].matches(of: regex).map(\.output.1))

  return raceData.reduce(1) { result, race in
    result * (1..<race.0).reduce(0) { winningRounds, curr in
      winningRounds + (curr * (race.0 - curr) > race.1 ? 1 : 0)
    }
  }
}

func day06Part2(input: String) -> Int {
  let rows = input.lines()
  let time = rows[0].filter { !$0.isWhitespace }.matches(of: regex).first!.output.1
  let distance = rows[1].filter { !$0.isWhitespace }.matches(of: regex).first!.output.1

  // using stride as it seems a lot more performant over several billion loops
  var total = 0
  for number in stride(from: 1, to: time, by: 1) {
    if (number * (time - number) > distance) {
      total += 1
    }
  }
  return total
}

private let regex = Regex {
  TryCapture {
    OneOrMore(.digit)
  } transform: { Int($0) }
}
