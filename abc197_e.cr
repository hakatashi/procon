def min(a, b)
  a > b ? b : a
end
def max(a, b)
  a < b ? b : a
end

n = read_line.to_i64
balls = [] of {Int64, Int64}
n.times do
  x, c = read_line.split.map(&.to_i64)
  balls << {x, c - 1}
end

lefts = Array(Int64 | Nil).new(n, nil)
rights = Array(Int64 | Nil).new(n, nil)

balls.each do |(x, c)|
  if lefts[c].nil? || x < lefts[c].not_nil!
    lefts[c] = x
  end
  if rights[c].nil? || rights[c].not_nil! < x
    rights[c] = x
  end
end

left_cost = 0_i64
right_cost = 0_i64
new_left_cost = 0_i64
new_right_cost = 0_i64
prev_left = 0_i64
prev_right = 0_i64

def get_right_cost(start, left, right)
  if start < left
    right - start
  else
    (start - left).abs + (right - left)
  end
end

def get_left_cost(start, left, right)
  if right < start
    start - left
  else
    (start - right).abs + (right - left)
  end
end

lefts.zip(rights).each do |left, right|
  next if left.nil? || right.nil?

  new_right_cost = min(
    left_cost + get_right_cost(prev_left, left, right),
    right_cost + get_right_cost(prev_right, left, right),
  )
  new_left_cost = min(
    left_cost + get_left_cost(prev_left, left, right),
    right_cost + get_left_cost(prev_right, left, right),
  )

  prev_left = left
  prev_right = right
  right_cost = new_right_cost
  left_cost = new_left_cost
end

left_cost += prev_left.abs
right_cost += prev_right.abs

p min(left_cost, right_cost)
