func day01Part1(input: String) -> Int {
  process(input: input)
}

func day01Part2(input: String) -> Int {
  process(input: transform(input: input))
}

private func process(input: String) -> Int {
  input.lines()
    .compactMap { line in
      let numbersInLine = line.matches(of: /\d/).map(\.output)
      return Int(numbersInLine.first! + numbersInLine.last!)
    }
    .sum()
}

private func transform(input: String) -> String {
  let numberMappings = [
    "one": "one1one",
    "two": "two2two",
    "three": "three3three",
    "four": "four4four",
    "five": "five5five",
    "six": "six6six",
    "seven": "seven7seven",
    "eight": "eight8eight",
    "nine": "nine9nine",
  ]

  return numberMappings.reduce(input) { $0.replacingOccurrences(of: $1.0, with: $1.1) }
}
