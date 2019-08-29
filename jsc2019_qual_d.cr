n = read_line.to_i
r = Array.new(n) { Array.new(n, 0) }
def colorize(lower, upper, depth, r)
  size = upper - lower
  left = size / 2
  right = size - left

  if left != 1
    colorize(lower, lower + left, depth + 1, r)
  end
  if right != 1
    colorize(lower + left, upper, depth + 1, r)
  end

  left.times do |i|
    right.times do |j|
      r[lower + i][lower + left + j] = depth
    end
  end
end
colorize(0, n, 1, r)
n.times do |i|
  vs = (n - i - 1).times.to_a.map do |j|
    r[i][j + i + 1]
  end
  puts vs.join(" ")
end