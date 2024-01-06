func day13Part1(input: String) -> Int {
  process(input, isPart1: true)
}

func day13Part2(input: String) -> Int {
  process(input, isPart1: false)
}

private func process(_ input: String, isPart1: Bool) -> Int {
  let blocks = input.split(separator: "\n\n")
  var total = 0
  for block in blocks {
    total += findMirror(from: block.lines(), isPart1: isPart1) * 100
    let transposedLines = block.lines().map { Array($0) }.transpose().map { String($0) }
    total += findMirror(from: transposedLines, isPart1: isPart1)
  }
  return total
}

private func findMirror(from grid: [String], isPart1: Bool) -> Int {
  for r in 1..<(grid.count) {
    let above = Array(grid[0..<r]).reversed().map { String($0) }
    let below = Array(grid[r..<grid.count])

    if isPart1 {
      if isAboveEqual(below: below, above: above) {
        return r
      }
    } else {
      let mismatchCount = zip(above, below).map { x, y in
        zip(x, y).filter { $0 != $1 }.count
      }.sum()

      if mismatchCount == 1 {
        return r
      }
    }
  }
  return 0
}

private func isAboveEqual(below: [String], above: [String]) -> Bool {
  let aboveTrimmed = (below.count > above.count) ? above : Array(above[0..<(below.count)])
  let belowTrimmed = (above.count > below.count) ? below : Array(below[0..<(above.count)])
  return aboveTrimmed == belowTrimmed
}

extension Array where Element: Collection {
  func transpose() -> [[Element.Iterator.Element]] {
    guard let firstRow = self.first else {
      return []
    }
    return (0..<firstRow.count).map { col in
      self.map { $0[$0.index($0.startIndex, offsetBy: col)] }
    }
  }
}
