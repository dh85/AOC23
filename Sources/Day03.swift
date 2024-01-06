func day03Part1(input: String) -> Int {
  let grid = input.lines()
  var coordinatesOfNumbers = Set<Coordinates>()

  for (rowIndex, row) in grid.enumerated() {
    for (charIndex, char) in row.enumerated() {
      guard !(char.isNumber || char == ".") else { continue }

      let numbersCoordinates = findCoordinatesOfNumbers(grid, at: rowIndex, charIndex: charIndex)
      coordinatesOfNumbers.formUnion(numbersCoordinates)
    }
  }

  let numbers = coordinatesOfNumbers.map { extractNumbers(from: grid, at: $0) }
  return numbers.sum()
}

func day03Part2(input: String) -> Int {
  let grid = input.lines()
  var total = 0

  for (rowIndex, row) in grid.enumerated() {
    for (charIndex, char) in row.enumerated() {
      guard char == "*" else { continue }

      let coordinatesOfNumbers = findCoordinatesOfNumbers(grid, at: rowIndex, charIndex: charIndex)

      guard coordinatesOfNumbers.count == 2 else { continue }

      let numbers = coordinatesOfNumbers.map { extractNumbers(from: grid, at: $0) }
      total += numbers[0] * numbers[1]
    }
  }

  return total
}

private func findCoordinatesOfNumbers(_ grid: [String], at rowIndex: Int, charIndex: Int) -> Set<Coordinates> {
  var coordinatesOfNumbers = Set<Coordinates>()

  for currentRow in [rowIndex - 1, rowIndex, rowIndex + 1] {
    for currentColumn in [charIndex - 1, charIndex, charIndex + 1] {
      guard currentRow >= 0,
            currentRow < grid.count,
            currentColumn >= 0,
            currentColumn < grid[currentRow].count,
            grid[currentRow][currentColumn].isNumber
      else {
        continue
      }

      var cc = currentColumn
      while cc > 0, grid[currentRow][cc - 1].isNumber {
        cc -= 1
      }
      coordinatesOfNumbers.insert(Coordinates(x: currentRow, y: cc))
    }
  }

  return coordinatesOfNumbers
}

private func extractNumbers(from grid: [String], at coordinates: Coordinates) -> Int {
  var start = ""
  let row = coordinates.x
  var column = coordinates.y

  while column < grid[row].count, grid[row][column].isNumber {
    start += String(grid[row][column])
    column += 1
  }
  return Int(start)!
}
