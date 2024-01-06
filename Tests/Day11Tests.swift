import XCTest
@testable import AOC23

final class Day11Tests: XCTestCase {
  private let input = """
  ...#......
  .......#..
  #.........
  ..........
  ......#...
  .#........
  .........#
  ..........
  .......#..
  #...#.....
  """

  func testPart1() {
    XCTAssertEqual(day11Part1(input: input), 374)
  }

  func testPart2() {
    XCTAssertEqual(day11Part2(input: input), 82000210)
  }
}
