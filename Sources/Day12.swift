func day12Part1(input: String) -> Int {
  process(input: input, isPart2: false)
}

func day12Part2(input: String) -> Int {
  process(input: input, isPart2: true)
}

private func process(input: String, isPart2: Bool) -> Int {
  let lines = input.lines()
  return lines
    .map { prepareData(line: $0, isPart2: isPart2) }
    .map { count(cfg: $0.cfg, nums: $0.nums, isPart2: isPart2) }
    .reduce(0, +)
}

private func prepareData(line: String, isPart2: Bool) -> (cfg: String, nums: [Int]) {
  let output = line.components(separatedBy: " ")
  let nums = output[1].components(separatedBy: ",").compactMap { Int($0) }
  let cfg = isPart2 ? Array(repeating: output[0], count: 5).joined(separator: "?") : output[0]
  return (cfg, isPart2 ? Array(repeating: nums, count: 5).flatMap { $0 } : nums)
}


private struct Pair: Hashable {
  let cfg: String
  let nums: [Int]
}

private var cache = [Pair: Int]()

private func count(cfg: String, nums: [Int], isPart2: Bool) -> Int {
  if cfg.isEmpty {
    return nums.isEmpty ? 1 : 0
  }

  if nums.isEmpty {
    return cfg.contains("#") ? 0 : 1
  }

  let key = Pair(cfg: cfg, nums: nums)
  if isPart2, let cachedValue = cache[key] {
    return cachedValue
  }

  var result = 0

  if ".?".contains(cfg.first!) {
    result += count(cfg: String(cfg.dropFirst()), nums: nums, isPart2: isPart2)
  }

  if "#?".contains(cfg.first!) {
    if nums[0] <= cfg.count && !cfg[0..<(nums[0])].contains(".") && (nums[0] == cfg.count || cfg[nums[0]] != "#") {
      let str = (nums[0] + 1) > cfg.count ? "" : String(cfg.dropFirst(nums[0] + 1))
      result += count(cfg: str, nums: Array(nums.dropFirst()), isPart2: isPart2)
    }
  }

  if isPart2 {
    cache[key] = result
  }

  return result
}

