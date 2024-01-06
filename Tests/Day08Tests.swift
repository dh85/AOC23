import XCTest
@testable import AOC23

final class Day08Tests: XCTestCase {
  func testPart1() {
    let input = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """
    XCTAssertEqual(day08Part1(input: input), 2)
  }

  func testPart2() {
    let input = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    XCTAssertEqual(day08Part2(input: input), 6)
  }
}
