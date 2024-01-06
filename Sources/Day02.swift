import RegexBuilder

func day02Part1(input: String) -> Int {
  let maxValidCubes = ["red": 12, "green": 13, "blue": 14]
  return input.components(separatedBy: .newlines)
    .enumerated()
    .filter { (_, line) in
      !line.matches(of: regex).contains { match in
        match[cubes] > maxValidCubes[match[color]]!
      }
    }
    .reduce(0) { $0 + $1.offset + 1 }
}

func day02Part2(input: String) -> Int {
  input.components(separatedBy: .newlines)
    .map { line in
      line.matches(of: regex)
        .reduce(into: [String: Int]()) { result, match in
          result[match[color], default: 0] = max(result[match[color], default: 0], match[cubes])
        }
        .values.reduce(1, *)
    }
    .sum()
}


private let cubes = Reference(Int.self)
private let color = Reference(String.self)

private let regex = Regex {
  TryCapture(as: cubes) {
    OneOrMore(.digit)
  } transform: {
    Int($0)
  }

  One(.whitespace)

  TryCapture(as: color) {
    ChoiceOf {
      "red"
      "green"
      "blue"
    }
  } transform: {
    String($0)
  }
}

//private let regex = /(?<cubes>\d+)\s(?<color>red|green|blue)/
