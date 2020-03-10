n, m = read_line.split.map(&.to_i64)
(2_i64 ** n - 1).times do |y|
  line = Array(Char).new(2_i64 ** n)
  (2_i64 ** m - 1).times do |x|
    if x % 2 == 1 && y % 2 == 1
      xf = 1
      until ((x + 1) >> xf) & 1 != 0
        xf += 1
      end
      yf = 1
      until ((y + 1) >> yf) & 1 != 0
        yf += 1
      end
      if xf == yf
        line << '0'
      else
        line << '1'
      end
    else
      line << '1'
    end
  end
  puts line.join
end
