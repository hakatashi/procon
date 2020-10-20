n = read_line.to_i64
ans = [] of String

def dfs(prefix, head, length)
  if length == 0
    puts prefix
  else
    head.times do |i|
      c = 'a' + i
      dfs(prefix + c, head, length - 1)
    end
    dfs(prefix + ('a' + head), head + 1, length - 1)
  end
end

dfs("", 0, n)
