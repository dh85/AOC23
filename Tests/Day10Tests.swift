import XCTest
@testable import AOC23

final class Day10Tests: XCTestCase {
  private let input = """
  ..........
  .S------7.
  .|F----7|.
  .||....||.
  .||....||.
  .|L-7F-J|.
  .|..||..|.
  .L--JL--J.
  ..........
  """

  func testPart1() {
    XCTAssertEqual(day10Part1(input: input), 22)
  }

  func testPart2() {
    XCTAssertEqual(day10Part2(input: input), 4)
  }
}
