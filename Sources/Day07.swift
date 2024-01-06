func day07Part1(input: String) -> Int {
  input.process(isPart2: false)
}

func day07Part2(input: String) -> Int {
  input.process(isPart2: true)
}

private extension String {
  func process(isPart2: Bool) -> Int {
    self.lines()
      .map(parsePuzzle)
      .map { Hand(from: $0, isPart2: isPart2) }
      .sorted()
      .enumerated()
      .map { ($0.offset + 1) * $0.element.bet }
      .sum()
  }

  private func parsePuzzle(_ puzzleString: String) -> (String, Int) {
    let puzzle = puzzleString.split(separator: " ")
    return (String(puzzle[0]), Int(puzzle[1])!)
  }
}

private struct Hand: Comparable {
  let cards: [Int]
  let bet: Int
  let type: HandType

  init(from puzzle: (hands: String, bet: Int), isPart2: Bool = false) {
    bet = puzzle.bet
    cards = Hand.parseCards(hands: puzzle.hands, isPart2: isPart2)
    type = Hand.getType(hands: puzzle.hands, isPart2: isPart2)
  }

  private static func parseCards(hands: String, isPart2: Bool) -> [Int] {
    hands.map { value in
      switch value {
      case "0"..."9": return Int(String(value))!
      case "T": return 10
      case "J": return isPart2 ? -1 : 11
      case "Q": return 12
      case "K": return 13
      case "A": return 14
      default: fatalError("Invalid value: \(value)")
      }
    }
  }

  private static func getType(hands: String, isPart2: Bool) -> HandType {
    let cards = hands.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    return isPart2 ? cards.getHandTypePart2() : cards.getHandType()
  }

  static func < (lhs: Hand, rhs: Hand) -> Bool {
    if lhs.type != rhs.type {
      return lhs.type < rhs.type
    }

    for (lValue, rValue) in zip(lhs.cards, rhs.cards) where lValue != rValue {
      return lValue < rValue
    }

    return false
  }
}

fileprivate enum HandType: Int, Comparable {
  case highest, pair, twoPair, three, fullHouse, four, five

  static func < (lhs: HandType, rhs: HandType) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}

private extension Dictionary where Key == Character, Value == Int {
  func getHandType() -> HandType {
    let maxCount = self.values.max()!

    switch maxCount {
    case 5: return .five
    case 4: return .four
    case _ where self.values.contains(2) && self.values.contains(3): return .fullHouse
    case 3: return .three
    case _ where self.values.filter { $0 == 2 }.count == 2: return .twoPair
    case 2: return .pair
    default: return .highest
    }
  }

  func getHandTypePart2() -> HandType {
    guard let jAmount = self["J"], jAmount != 0 else {
      return getHandType()
    }

    guard jAmount != 5 && jAmount != 4 else {
      return .five
    }

    var mutable = self
    mutable["J"] = nil
    let hand = mutable.getHandType()

    switch (hand, jAmount) {
    case (.four, 1), (.three, 2), (.pair, 3): return .five
    case (.three, 1), (.pair, 2), (.highest, 3): return .four
    case (.twoPair, 1): return .fullHouse
    case (.highest, 2), (.pair, 1): return .three
    case (.highest, 1): return .pair
    default: fatalError("Invalid combination")
    }
  }
}
