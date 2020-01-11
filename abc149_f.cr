require "big_int"
require "big_rational"

n = read_line.to_i
pres = Array(Array(Int32)).new(n) { [] of Int32 }
(n - 1).times do |i|
  a, b = read_line.split.map(&.to_i)
  pres[a - 1] << b - 1
  pres[b - 1] << a - 1
end

def dfs(node, parent, pres)
  children = [] of Tuple(BigRational, BigRational)
  count = 0_i64
  pres[node].each do |pre|
    next if pre == parent
    c_count, c_exp, c_pot = dfs(pre, parent, pres)
    p [c_count, c_exp, c_pot]
    count += c_count
    children << {c_exp, c_pot}
  end

  if children.size == 0
    {
      1,
      BigRational.new(0, 1),
      BigRational.new(0, 1),
    }
  else
    expectation = BigRational.new(1, 2)
    potential = BigRational.new(1.to_big_i << count - 1, 1.to_big_i << count)

    children.each do |(c_exp, c_pot)|
      expectation += c_pot / 2
      expectation += c_exp
      potential += c_pot / 2
    end

    {
      count + 1,
      expectation,
      potential,
    }
  end
end

p dfs(0, -1, pres)