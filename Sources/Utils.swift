import Foundation

func readFile(_ name: String) -> String {
  guard let path = Bundle.module.path(forResource: name, ofType: nil) else {
    fatalError("Invalid file: \(name)")
  }

  return try! String(contentsOfFile: path)
    .trimmingCharacters(in: .whitespacesAndNewlines)
}

func readInput(_ day: Int) -> String {
  let numStr = String(format: "%02d", day)
  return readFile("day\(numStr).txt")
}

func printDay(_ day: String, _ part1: (String) -> Int, _ part2: (String) -> Int) {
    let input = readFile("day\(day).txt")
    print("Day \(day):")
    print("  Part 1:", part1(input))
    print("  Part 2:", part2(input))
}

extension String.SubSequence {
  func lines() -> [String] { components(separatedBy: .newlines) }
}

extension String {
  func lines() -> [String] {
    var strings = components(separatedBy: .newlines)
    if strings.last?.isEmpty == true {
      _ = strings.removeLast()
    }
    return strings
  }
}

extension Collection where Element: Numeric {
  func sum() -> Element { reduce(0, +) }
}

struct Coordinates: Hashable {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

extension String {
  private func nearestIndex(pos:Int) -> String.Index {
    if pos >= count {
      return index(before: endIndex)
    }
    if pos <= 0 {
      return startIndex
    }
    if pos < (count / 2) {
      return index(startIndex, offsetBy: pos)
    } else {
      return index(endIndex, offsetBy: -(count-pos))
    }
  }

  //Allow string[Int] subscripting
  subscript(index: Int) -> Character {
    return self[self.index(self.startIndex, offsetBy: index)]
  }

  //Allow open ranges like `string[0..<n]`
  subscript(range: Range<Int>) -> Substring {
    let start = self.index(self.startIndex, offsetBy: range.lowerBound)
    let end = self.index(self.startIndex, offsetBy: range.upperBound)
    return self[start..<end]
  }

  //Allow closed integer range subscripting like `string[0...n]`
  subscript(range: ClosedRange<Int>) -> Substring {
    let start = self.index(self.startIndex, offsetBy: range.lowerBound)
    let end = self.index(self.startIndex, offsetBy: range.upperBound)
    return self[start...end]
  }

  subscript (range: PartialRangeUpTo<Int>) -> Substring {
    return self[startIndex..<nearestIndex(pos: range.upperBound)]
  }

  subscript (range:PartialRangeFrom<Int>) -> Substring {
    return self[nearestIndex(pos: range.lowerBound)...index(before: endIndex)]
  }
}


