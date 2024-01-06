import XCTest
@testable import AOC23

final class Day13Tests: XCTestCase {
  private let input = """
  #.##..##.
  ..#.##.#.
  ##......#
  ##......#
  ..#.##.#.
  ..##..##.
  #.#.##.#.

  #...##..#
  #....#..#
  ..##..###
  #####.##.
  #####.##.
  ..##..###
  #....#..#
  """

  func testPart1() {
    XCTAssertEqual(day13Part1(input: input), 405)
  }

  func testPart2() {
    XCTAssertEqual(day13Part2(input: input), 400)
  }
}
