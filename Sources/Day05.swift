import RegexBuilder

func day05Part1(input: String) -> Int {
  let rows = input.split(separator: "\n")
  let seeds = extractSeeds(from: rows[0])

  var idx = 2

  var currentValues = seeds
  while idx < rows.count {
    let (mapping, newIdx) = parseMapping(startIdx: idx, rows: rows)
    var nextValues: [Int] = []
    for value in currentValues {
      var newValue = value
      for (range, offset) in mapping {
        if range.contains(value) {
          newValue = value + offset
          break
        }
      }
      nextValues.append(newValue)
    }
    currentValues = nextValues
    idx = newIdx + 1
  }

  return currentValues.min()!
}

func day05Part2(input: String) -> Int {
  let rows = input.split(separator: "\n")
  var seedRanges = getSeedRanges(from: rows[0])
    .sorted { $0.lowerBound < $1.lowerBound }
  let mappings = getMappings(from: rows)

  for mapping in mappings {
    var mappedSeeds: [Range<Int>] = []
    let sortedMappings = mapping.sorted { $0.key.lowerBound < $1.key.lowerBound }

    for seedRange in seedRanges {
      var currentLowest = seedRange.lowerBound
      for (mappingRange, offset) in sortedMappings where mappingRange.overlaps(seedRange) {
        if currentLowest < mappingRange.lowerBound {
          mappedSeeds.append(currentLowest..<mappingRange.lowerBound)
        }
        let lower = max(currentLowest, mappingRange.lowerBound) + offset
        let upper = min(mappingRange.upperBound, seedRange.upperBound) + offset
        mappedSeeds.append(lower..<upper)
        currentLowest = min(mappingRange.upperBound, seedRange.upperBound)
      }
      if currentLowest < seedRange.upperBound {
        mappedSeeds.append(currentLowest..<seedRange.upperBound)
      }
    }
    seedRanges = mappedSeeds
  }
  return seedRanges.min { $0.lowerBound < $1.lowerBound }!.lowerBound
}

private let regex = Regex {
  TryCapture {
    OneOrMore(.digit)
  } transform: { Int($0) }
}

private func getMappings(from rows: [Substring]) -> [[Range<Int>: Int]] {
  var idx = 2
  var mappings: [[Range<Int>: Int]] = []
  while idx < rows.count {
    let (mapping, newIdx) = parseMapping(startIdx: idx, rows: rows)
    mappings.append(mapping)
    idx = newIdx + 1
  }
  return mappings
}

private func getSeedRanges(from input: Substring) -> [Range<Int>] {
  let seedColon = input.firstIndex(of: ":")!
  let seeds = input[seedColon...].matches(of: regex).map(\.output.1)
  var seedRanges: [Range<Int>] = []
  for seed in stride(from: 0, to: seeds.count, by: 2) {
    let start = seeds[seed]
    let length = seeds[seed + 1]
    seedRanges.append(start..<(start + length))
  }
  return seedRanges
}

private func extractSeeds(from row: Substring) -> [Int] {
  let seedColon = row.firstIndex(of: ":")!
  return row[seedColon...].matches(of: regex).map(\.output.1)
}

private func parseMapping(startIdx: Int, rows: [Substring]) -> ([Range<Int>: Int], Int) {
  var toMap: [Range<Int>: Int] = [:]
  for (idx, row) in rows[startIdx...].enumerated() {
    guard row.first!.isNumber else {
      return (toMap, idx + startIdx)
    }
    let values = row.matches(of: regex).map(\.output.1)
    let range = values[1]..<(values[1] + values[2])
    let offset = values[0] - values[1]
    toMap[range] = offset
  }
  return (toMap, rows.count)
}
