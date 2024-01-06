func day09Part1(input: String) -> Int {
  calculateResult(input: input) { findNextValue(for: $0, extrapolation: extrapolateNextValue) }
}

func day09Part2(input: String) -> Int {
  calculateResult(input: input) { findNextValue(for: $0, extrapolation: extrapolatePreviousValue) }
}

private func calculateResult(input: String, valueCalculator: ([Int]) -> Int) -> Int {
  mappedInput(input).map(valueCalculator).sum()
}

private func mappedInput(_ input: String) -> [[Int]] {
  input.lines().map { row in row.split(separator: " ").map { Int(String($0))! } }
}

private func findNextValue(for sequence: [Int], extrapolation: (ArraySlice<[Int]>) -> Int) -> Int {
  var differences = [sequence]
  while let current = differences.last, current.contains(where: { $0 != 0 }) {
    let next = getDifferences(for: current)
    differences.append(next)
  }

  let value = extrapolation(differences[0...])
  return value
}

private func getDifferences(for sequence: [Int]) -> [Int] {
  guard sequence.count != 1 else { return [0] }
  return (0..<(sequence.count - 1)).map { sequence[$0 + 1] - sequence[$0] }
}

private func extrapolateNextValue(for sequences: ArraySlice<[Int]>) -> Int {
  switch sequences.count {
  case 0: fatalError()
  case 1: sequences.first!.last!
  default: extrapolateNextValue(for: sequences.dropFirst()) + sequences.first!.last!
  }
}

private func extrapolatePreviousValue(for sequences: ArraySlice<[Int]>) -> Int {
  switch sequences.count {
  case 0: fatalError()
  case 1: sequences.first!.last!
  default: sequences.first!.first! - extrapolatePreviousValue(for: sequences.dropFirst())
  }
}
