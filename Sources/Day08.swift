import RegexBuilder

func day08Part1(input: String) -> Int {
  calculateStepsToFinish(input: mappedInput(input), start: "AAA") { $0 == "ZZZ" }
}

func day08Part2(input: String) -> Int {
  let input = mappedInput(input)
  let current = input.mapping.keys.filter { $0.last == "A" }
  let stepsNeeded = current.map {
    calculateStepsToFinish(input: input, start: $0) { $0.last == "Z"}
  }
  return leastCommonMultiple(numbers: stepsNeeded)
}

private typealias Mapping = [String: (left: String, right: String)]

private func mappedInput(_ input: String) -> (directions: String, mapping: Mapping) {
  let puzzle = input.components(separatedBy: "\n\n")
  let directions = puzzle.first!
  let nodes = puzzle.last!

  let mapping = nodes.matches(of: regex).reduce(into: Mapping()) { acc, match in
    acc[match[node]] = (match[leftNode], match[rightNode])
  }

  return (directions, mapping)
}

private func calculateStepsToFinish(input: (directions: String, mapping: Mapping), start: String, isFinished: (String) -> Bool) -> Int {
  var current = start
  var steps = 0
  var idx = input.directions.startIndex

  while !isFinished(current) {
    let directions = input.directions[idx]
    let nextValues = input.mapping[current]!
    switch directions {
    case "R":
      current = nextValues.right
    case "L":
      current = nextValues.left
    default:
      fatalError()
    }
    steps += 1
    idx = input.directions.index(after: idx)
    if idx == input.directions.endIndex {
      idx = input.directions.startIndex
    }
  }
  return steps
}

private func leastCommonMultiple(numbers: [Int]) -> Int {
  guard let primes = findPrimesUntil(limit: numbers.max()!) else {
    return numbers.reduce(1, *)
  }
  var values = numbers
  var res = 1
  var currPrimeIdx = 0

  while values.contains(where: { $0 != 1 }) {
    var found = false
    for (idx, value) in values.enumerated() {
      if value % primes[currPrimeIdx] == 0 {
        values[idx] /= primes[currPrimeIdx]
        found = true
      }
    }
    if !found {
      currPrimeIdx += 1
    } else {
      res *= primes[currPrimeIdx]
    }
  }
  return res
}

private func findPrimesUntil(limit: Int) -> [Int]? {
  guard limit > 1 else {
    return nil
  }

  var primes =  [Bool](repeating: true, count: limit+1)

  for i in 0..<2 {
    primes[i] = false
  }

  for j in 2..<primes.count where primes[j] {
    var k = 2
    while k * j < primes.count {
      primes[k * j] = false
      k += 1
    }
  }

  return primes.enumerated().compactMap { (index: Int, element: Bool) -> Int? in
    if element {
      return index
    }
    return nil
  }
}

private let node = Reference(String.self)
private let leftNode = Reference(String.self)
private let rightNode = Reference(String.self)

private let regex = Regex {
  TryCapture(as: node) {
    OneOrMore(.word)
  } transform: {
    String($0)
  }
  " = ("
  TryCapture(as: leftNode) {
    OneOrMore(.word)
  } transform: {
    String($0)
  }
  ", "
  TryCapture(as: rightNode) {
    OneOrMore(.word)
  } transform: {
    String($0)
  }
  ")"
}
