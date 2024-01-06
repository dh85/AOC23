import XCTest
@testable import AOC23

final class Day07Tests: XCTestCase {
  private let input = """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  func testPart1() {
    XCTAssertEqual(day07Part1(input: input), 6440)
  }

  func testPart2() {
    XCTAssertEqual(day07Part2(input: input), 5905)
  }
}
