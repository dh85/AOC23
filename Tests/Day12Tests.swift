import XCTest
@testable import AOC23

final class Day12Tests: XCTestCase {
  private let input = """
  ???.### 1,1,3
  .??..??...?##. 1,1,3
  ?#?#?#?#?#?#?#? 1,3,1,6
  ????.#...#... 4,1,1
  ????.######..#####. 1,6,5
  ?###???????? 3,2,1
  """

  func testPart1() {
    XCTAssertEqual(day12Part1(input: input), 21)
  }

  func testPart2() {
    XCTAssertEqual(day12Part2(input: input), 525152)
  }
}
