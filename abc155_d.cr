def max(a, b)
  a > b ? a : b
end
def min(a, b)
  a < b ? a : b
end

n, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort
rev_ais = ais.reverse
ans = (-1_000_000_000_000_000_000_i64..1_000_000_000_000_000_000_i64).bsearch do |i|
  ret = 0_i64
  ais.each_with_index do |a, j|
    if a < 0
      i2 = rev_ais.bsearch_index {|a2| a2 * a >= i}
      unless i2.nil?
        ret += min(n - i2 - j - 1, n - j - 1)
      end
    elsif a == 0
      if i <= 0
        ret += n - j - 1
      end
    else
      i2 = ais.bsearch_index {|a2| a2 * a >= i}
      unless i2.nil?
        ret += min(n - i2 - 1, n - j - 1)
      end
    end
  end
  p [i, ret]
  ret >= k
end
p ans