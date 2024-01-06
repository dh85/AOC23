func day11Part1(input: String) -> Int {
  process(input: input, scale: 2)
}

func day11Part2(input: String) -> Int {
  process(input: input, scale: 1_000_000)
}

private func process(input: String, scale: Int) -> Int {
  let grid = input.lines()
  let emptyRows = findEmptyRows(for: grid)
  let emptyCols = findEmptyColumns(for: grid)
  let points = findOccupiedPoints(for: grid)
  return calculateTotal(emptyRows: emptyRows, emptyCols: emptyCols, points: points, scale: scale)
}

private func findEmptyRows(for grid: [String]) -> [Int] {
  grid.indices.filter { r in grid[r].allSatisfy { $0 == "." } }
}

private func findEmptyColumns(for grid: [String]) -> [Int] {
  grid[0].indices
    .filter { c in grid.allSatisfy { $0[c] == "." } }
    .map { grid[0].distance(from: grid[0].startIndex, to: $0) }
}

private func findOccupiedPoints(for grid: [String]) -> [Coordinates] {
  grid.enumerated().flatMap { r, row in
    row.enumerated().compactMap { c, ch in
      ch == "#" ? Coordinates(x: r, y: c) : nil
    }
  }
}

private func calculateTotal(emptyRows: [Int], emptyCols: [Int], points: [Coordinates], scale: Int) -> Int {
  var total = 0

  for (i, point1) in points.enumerated() {
    for (j, point2) in points.enumerated() where j < i {
      let (r1, c1) = (point1.x, point1.y)
      let (r2, c2) = (point2.x, point2.y)

      total += calculateEmptyRowsTotal(emptyRows: emptyRows, r1: r1, r2: r2, scale: scale)
      total += calculateEmptyColsTotal(emptyCols: emptyCols, c1: c1, c2: c2, scale: scale)
    }
  }

  return total
}

private func calculateEmptyRowsTotal(emptyRows: [Int], r1: Int, r2: Int, scale: Int) -> Int {
  (min(r1, r2)..<max(r1, r2)).reduce(0) { $0 + (emptyRows.contains($1) ? scale : 1) }
}

private func calculateEmptyColsTotal(emptyCols: [Int], c1: Int, c2: Int, scale: Int) -> Int {
  (min(c1, c2)..<max(c1, c2)).reduce(0) { $0 + (emptyCols.contains($1) ? scale : 1) }
}
