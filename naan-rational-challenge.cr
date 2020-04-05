# -*- status: skip -*-

require "big"
require "set"

EDAKARI = 1000000

def is_prime(n)
  i = 2
  while i * i <= n
    if n % i == 0
      return false
    end
    i += 1
  end
  true
end

def max(a, b)
  a > b ? a : b
end

dp1 = Set(BigRational).new(10000000)
dp1 << BigRational.new(0, 1)

dp2 = Set(BigRational).new(10000000)
dp2 << BigRational.new(1, 1)

# target = BigRational.new(1, 1) - BigRational.new(1, 76) - BigRational.new(1, 75) - BigRational.new(1, 72) - BigRational.new(1, 63) - BigRational.new(1, 60) - BigRational.new(1, 57) - BigRational.new(1, 56) - BigRational.new(1, 54) - BigRational.new(1, 50) - BigRational.new(1, 45) - BigRational.new(1, 42) - BigRational.new(1, 40) - BigRational.new(1, 36) - BigRational.new(1, 35) - BigRational.new(1, 30) - BigRational.new(1, 27) - BigRational.new(1, 24) - BigRational.new(1, 20) - BigRational.new(1, 19) - BigRational.new(1, 15) - BigRational.new(1, 12) - BigRational.new(1, 9) - BigRational.new(1, 4)
candidates = (2..100).to_a.reject {|n| is_prime(n) && n >= 50}

max_counts1 = Hash(BigRational, Int32).new(0)
counts1 = Hash(BigRational, Array(Tuple(Int32, Int32))).new {|h, k| h[k] = [] of Tuple(Int32, Int32)}
counts1[BigRational.new(0, 1)] << {0, 0}

max_counts2 = Hash(BigRational, Int32).new(0)
counts2 = Hash(BigRational, Array(Tuple(Int32, Int32))).new {|h, k| h[k] = [] of Tuple(Int32, Int32)}
counts2[BigRational.new(1, 1)] << {0, 0}

candidates_half1 = candidates[0...(candidates.size // 2)]
candidates_half2 = candidates[(candidates.size // 2)..].reverse

candidates_half1.each do |candidate|
  p candidate
  new_dp1 = dp1.dup
  new_max_counts = Hash(BigRational, Int32).new(0)
  dp1.each do |r|
    new_r = r + BigRational.new(1, candidate)
    new_max_counts[r] = max(new_max_counts[r], max_counts1[r])
    if new_r < 1 && new_r.denominator < EDAKARI
      new_dp1 << new_r
      new_max_counts[new_r] = max(new_max_counts[new_r], max_counts1[r] + 1)
      counts1[new_r] << {candidate, new_max_counts[new_r]}
    end
  end
  dp1 = new_dp1
  max_counts1 = new_max_counts
end

candidates_half2.each do |candidate|
  p candidate
  new_dp2 = dp2.dup
  new_max_counts = Hash(BigRational, Int32).new(0)
  dp2.each do |r|
    new_r = r - BigRational.new(1, candidate)
    new_max_counts[r] = max(new_max_counts[r], max_counts2[r])
    if new_r > 0 && new_r.denominator < EDAKARI
      new_dp2 << new_r
      new_max_counts[new_r] = max(new_max_counts[new_r], max_counts2[r] + 1)
      counts2[new_r] << {candidate, new_max_counts[new_r]}
    end
  end
  dp2 = new_dp2
  max_counts2 = new_max_counts
end

max = (dp1 & dp2).max_by do |r|
  max_counts1[r] + max_counts2[r]
end

denominators = [] of Int32

current_r = max
current_count = max_counts1[max]
until current_count == 0
  latest, count = counts1[current_r].find {|(latest, count)| count == current_count && (denominators.empty? || latest != denominators.last)} .not_nil!
  current_r -= BigRational.new(1, latest)
  denominators << latest
  current_count -= 1
end

current_r = max
current_count = max_counts2[max]
until current_count == 0
  latest, count = counts2[current_r].find {|(latest, count)| count == current_count && (denominators.empty? || latest != denominators.last)} .not_nil!
  current_r += BigRational.new(1, latest)
  denominators << latest
  current_count -= 1
end

p denominators.sort.map {|d| "1/#{d}"} .join(" + ") + " = 1"