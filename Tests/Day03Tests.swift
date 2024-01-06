import XCTest
@testable import AOC23

final class Day03Tests: XCTestCase {
  private let input = """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  func testPart1() {
    XCTAssertEqual(day03Part1(input: input), 4361)
  }

  func testPart2() {
    XCTAssertEqual(day03Part2(input: input), 467835)
  }
}
