def is5pow(n)
  ret = 0_i64
  until n <= 1
    if n % 5 != 0
      return -1_i64
    end
    n //= 5
    ret += 1
  end
  if n == 1
    return ret
  else
    return -1_i64
  end
end
n = read_line.to_i64
x = 1_i64
until 3_i64 ** x > n
  if is5pow(n - 3_i64 ** x) != -1 && is5pow(n - 3_i64 ** x) != 0
    puts "#{x} #{is5pow(n - 3_i64 ** x)}"
    exit
  end
  x += 1
end
p -1