import XCTest
@testable import AOC23

final class Day06Tests: XCTestCase {
  private let input = """
  Time:      7  15   30
  Distance:  9  40  200
  """

  func testPart1() {
    XCTAssertEqual(day06Part1(input: input), 288)
  }

  func testPart2() {
    XCTAssertEqual(day06Part2(input: input), 71503)
  }
}
