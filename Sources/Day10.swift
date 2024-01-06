func day10Part1(input: String) -> Int {
  let grid = input.components(separatedBy: .newlines)
  let startCoords = findStartCoordinates(grid: grid)

  var loop: Set<Coordinates> = [startCoords]
  var deque = [startCoords]

  while !deque.isEmpty {
    let coords = deque.removeFirst()
    let row = coords.x
    let col = coords.y
    let ch = grid[row][col]

    if row > 0 && "S|JL".contains(ch) && "|7F".contains(grid[row - 1][col]) && !loop.contains(.init(x: row - 1, y: col)) {
      loop.insert(.init(x: row - 1, y: col))
      deque.append(.init(x: row - 1, y: col))
    }

    if row < grid.count - 1 && "S|7F".contains(ch) && "|JL".contains(grid[row + 1][col]) && !loop.contains(.init(x: row + 1, y: col)) {
      loop.insert(.init(x: row + 1, y: col))
      deque.append(.init(x: row + 1, y: col))
    }

    if col > 0 && "S-J7".contains(ch) && "-LF".contains(grid[row][col - 1]) && !loop.contains(.init(x: row, y: col - 1)) {
      loop.insert(.init(x: row, y: col - 1))
      deque.append(.init(x: row, y: col - 1))
    }

    if col < grid[row].count - 1 && "S-LF".contains(ch) && "-J7".contains(grid[row][col + 1]) && !loop.contains(.init(x: row, y: col + 1)) {
      loop.insert(.init(x: row, y: col + 1))
      deque.append(.init(x: row, y: col + 1))
    }
  }

  return loop.count / 2
}

func day10Part2(input: String) -> Int {
  var grid = input.lines()
  let startCoords = findStartCoordinates(grid: grid)

  var loop: Set<Coordinates> = [startCoords]
  var deque = [startCoords]

  var maybe: Set<Character> = [Character("|"), Character("-"), Character("J"), Character("L"), Character("7"), Character("F")]

  while !deque.isEmpty {
    let coords = deque.removeFirst()
    let row = coords.x
    let col = coords.y
    let ch = grid[row][col]

    if row > 0 && "S|JL".contains(ch) && "|7F".contains(grid[row - 1][col]) && !loop.contains(.init(x: row - 1, y: col)) {
      loop.insert(.init(x: row - 1, y: col))
      deque.append(.init(x: row - 1, y: col))
      if ch == "S" {
        let set: Set<Character> = [Character("|"), Character("J"), Character("L")]
        maybe = maybe.intersection(set)
      }
    }

    if row < grid.count - 1 && "S|7F".contains(ch) && "|JL".contains(grid[row + 1][col]) && !loop.contains(.init(x: row + 1, y: col)) {
      loop.insert(.init(x: row + 1, y: col))
      deque.append(.init(x: row + 1, y: col))
      if ch == "S" {
        let set: Set<Character> = [Character("|"), Character("7"), Character("F")]
        maybe = maybe.intersection(set)
      }
    }

    if col > 0 && "S-J7".contains(ch) && "-LF".contains(grid[row][col - 1]) && !loop.contains(.init(x: row, y: col - 1)) {
      loop.insert(.init(x: row, y: col - 1))
      deque.append(.init(x: row, y: col - 1))
      if ch == "S" {
        let set: Set<Character> = [Character("-"), Character("J"), Character("7")]
        maybe = maybe.intersection(set)
      }
    }

    if col < grid[row].count - 1 && "S-LF".contains(ch) && "-J7".contains(grid[row][col + 1]) && !loop.contains(.init(x: row, y: col + 1)) {
      loop.insert(.init(x: row, y: col + 1))
      deque.append(.init(x: row, y: col + 1))
      if ch == "S" {
        let set: Set<Character> = [Character("-"), Character("L"), Character("F")]
        maybe = maybe.intersection(set)
      }
    }
  }

  assert(maybe.count == 1)

  let s = maybe.first!
  grid = grid.map { $0.replacingOccurrences(of: "S", with: String(s)) }
  grid = grid.enumerated().map { r, row in
    row.enumerated().map { c, ch in
      loop.contains(Coordinates(x: r, y: c)) ? String(ch) : "."
    }.joined()
  }

  var outside = Set<Coordinates>()

  for (r, row) in grid.enumerated() {
    var within = false
    var up: Bool? = nil

    for (c, ch) in row.enumerated() {
      switch ch {
      case "|":
        assert(up == nil)
        within.toggle()
      case "-":
        assert(up != nil)
      case "L", "F":
        assert(up == nil)
        up = ch == "L"
      case "7", "J":
        assert (up != nil)
        if ch != (up == true ? "J" : "7")  {
          within.toggle()
        }
        up = nil
      case ".":
        break
      default:
        fatalError("unexpected character (horizontal): \(ch)")
      }

      if !within {
        outside.insert(Coordinates(x: r, y: c))
      }
    }
  }
  
  return grid.count * grid[0].count - (outside.union(loop)).count
}

private func findStartCoordinates(grid: [String]) -> Coordinates {
  grid.enumerated()
    .flatMap { r, row in row.enumerated().map { c, ch in (Coordinates(x: r, y: c), ch) } }
    .first { $0.1 == "S" }?.0 ?? Coordinates(x: 0, y: 0)
}
