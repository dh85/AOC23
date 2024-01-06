import XCTest
@testable import AOC23

final class Day09Tests: XCTestCase {
  private let input = """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  func testPart1() {
    XCTAssertEqual(day09Part1(input: input), 114)
  }

  func testPart2() {
    XCTAssertEqual(day09Part2(input: input), 2)
  }
}
