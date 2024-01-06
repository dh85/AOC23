func day04Part1(input: String) -> Int {
  return parseInput(input).reduce(0) { acc, numbers in
    acc + numbers.scratched.reduce(1) { tempAcc, value in
      numbers.winning.contains(value) ? (tempAcc << 1) : tempAcc
    } / 2
  }
}

func day04Part2(input: String) -> Int {
    let inputPairs = parseInput(input)
    var cardAmount = Array(repeating: 1, count: inputPairs.count)

    for (idx, (winning, scratched)) in inputPairs.enumerated() {
        let found = scratched.intersection(winning).count

        guard found > 0 else { continue }

        for offset in 1...found where offset + idx < inputPairs.count {
            cardAmount[idx + offset] += cardAmount[idx]
        }
    }

    return cardAmount.sum()
}

private func parseInput(_ input: String) -> [(winning: Set<Int>, scratched: Set<Int>)] {
  return input.lines()
    .map { row in
      let allNumbers = row.split(separator: ":").last!.split(separator: "|")
      let winningNumbers = Set(allNumbers[0].matches(of: /\d+/).compactMap { Int($0.output) })
      let scratchedNumbers = Set(allNumbers[1].matches(of: /\d+/).compactMap { Int($0.output) })
      return (winningNumbers, scratchedNumbers)
    }
}
