require "big"
t = read_line.to_i64

class Solve
  getter :dp

  def initialize(@a : Int64, @b : Int64, @c : Int64, @d : Int64)
    @dp = Hash(Int64, Int64).new
  end

  def solve(n)
    return 0_i64 if n == 0
    return @d if n == 1
    return @dp[n] if @dp.has_key?(n)

    if n.to_big_i * @d > Int64::MAX
      ans = Int64::MAX
    else
      ans = n * @d
    end

    t = n // 2
    k = solve(t) + @a + (n - t * 2) * @d
    ans = k if k < ans

    t = (n + 1) // 2
    k = solve(t) + @a + (t * 2 - n) * @d
    ans = k if k < ans

    t = n // 3
    k = solve(t) + @b + (n - t * 3) * @d
    ans = k if k < ans

    t = (n + 2) // 3
    k = solve(t) + @b + (t * 3 - n) * @d
    ans = k if k < ans

    t = n // 5
    k = solve(t) + @c + (n - t * 5) * @d
    ans = k if k < ans

    t = (n + 4) // 5
    k = solve(t) + @c + (t * 5 - n) * @d
    ans = k if k < ans

    @dp[n] = ans
    ans
  end
end

t.times do
  n, a, b, c, d = read_line.split.map(&.to_i64)
  solve = Solve.new(a, b, c, d)
  p solve.solve(n)
end
