n, k = read_line.split.map(&.to_i64)
zeros = Array(Int64).new(n)
positives = Array(Int64).new(n)
negatives = Array(Int64).new(n)
read_line.split.map do |ra|
  a = ra.to_i64
  if a == 0
    zeros << a
  elsif a < 0
    negatives << a
  else
    positives << a
  end
end
positives.sort!
negatives.sort_by! {|a| a.abs}

# iより小さいかiと等しい個数がk個より多いかk個ならtrueを返すこと
ans = (-1_000_000_000_000_000_000_i64..1_000_000_000_000_000_000_i64).bsearch do |i|
  # iより小さいか等しい個数
  ret = 0_i64
  if i > 0
    ptr = positives.size.to_i64 - 1 # positives[ptr] * a <= i となる最小のインデックス
    positives.each_with_index do |a, j|
      until ptr < 0 || positives[ptr] * a <= i
        ptr -= 1
      end
      if a * a <= i
        # 自分自身を除く
        ret += ptr
      else
        ret += ptr + 1
      end
    end
    ptr = negatives.size.to_i64 - 1
    negatives.each_with_index do |a, j|
      until ptr < 0 || negatives[ptr] * a <= i
        ptr -= 1
      end
      if a * a <= i
        # 自分自身を除く
        ret += ptr
      else
        ret += ptr + 1
      end
    end
    ret += zeros.size.to_i64 * (n - zeros.size) * 2 + zeros.size.to_i64 * (zeros.size - 1)
    ret += positives.size.to_i64 * negatives.size * 2
  elsif i == 0
    ret += zeros.size.to_i64 * (n - zeros.size) * 2 + zeros.size.to_i64 * (zeros.size - 1)
    ret += positives.size.to_i64 * negatives.size * 2
  else
    ptr = negatives.size.to_i64 - 1 # negatives[ptr] * a > i となる最大のインデックス
    positives.each_with_index do |a, j|
      until ptr < 0 || negatives[ptr] * a > i
        ptr -= 1
      end
      ret += (negatives.size - 1 - ptr) * 2
    end
  end
  ret // 2 >= k
end
p ans