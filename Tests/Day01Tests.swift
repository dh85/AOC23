import XCTest
@testable import AOC23

final class Day01Tests: XCTestCase {
  func testPart1() {
    let input = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
    XCTAssertEqual(day01Part1(input: input), 142)
  }

  func testPart2() {
    let input = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    XCTAssertEqual(day01Part2(input: input), 281)
  }
}
