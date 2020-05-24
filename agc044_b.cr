def min(a, b)
  a > b ? b : a
end

n = read_line.to_i32
ps = read_line.split.map(&.to_i32)
dists = Array(Int32).new(n * n, 0_i32)
set = Array(Bool).new(n * n, true)
n.times do |y|
  n.times do |x|
    i = y * n + x
    dists[i] = min(min(min(x, y), n - x - 1), n - y - 1)
  end
end

ans = 0_i32
queue = Deque(Tuple(Int32, Int32)).new(n * n * n // 8)
ps.each do |pv|
  i = pv - 1
  ans += dists[i]
  set[i] = false

  x = i % n
  y = i // n
  if x - 1 >= 0
    k = y * n + x - 1
    queue << {k, dists[i]}
  end
  if x + 1 < n
    k = y * n + x + 1
    queue << {k, dists[i]}
  end
  if y - 1 >= 0
    k = (y - 1) * n + x
    queue << {k, dists[i]}
  end
  if y + 1 < n
    k = (y + 1) * n + x
    queue << {k, dists[i]}
  end
  until queue.empty?
    j, depth = queue.shift
    next if dists[j] <= depth
    dists[j] = depth

    x = j % n
    y = j // n
    if x - 1 >= 0
      k = y * n + x - 1
      queue << {k, set[j] ? depth + 1 : depth}
    end
    if x + 1 < n
      k = y * n + x + 1
      queue << {k, set[j] ? depth + 1 : depth}
    end
    if y - 1 >= 0
      k = (y - 1) * n + x
      queue << {k, set[j] ? depth + 1 : depth}
    end
    if y + 1 < n
      k = (y + 1) * n + x
      queue << {k, set[j] ? depth + 1 : depth}
    end
  end
end
p ans
