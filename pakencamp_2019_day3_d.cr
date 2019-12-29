INF = 0xFFFFFFF
n = read_line.to_i
counts = Array(Array(Int32)).new(n) { [0, 0, 0, 0] }
5.times do
  read_line.chars.each_with_index do |c, i|
    case c
    when 'R'
      counts[i][0] += 1
    when 'B'
      counts[i][1] += 1
    when 'W'
      counts[i][2] += 1
    when '#'
      counts[i][3] += 1
    end
  end
end
dp = Array(Array(Int32)).new(n + 1) { [INF, INF, INF] }
dp[0][0] = 0
dp[0][1] = 0
dp[0][2] = 0
n.times do |i|
  tmp = dp[i][1] + counts[i][1] + counts[i][2] + counts[i][3]
  dp[i + 1][0] = tmp if dp[i + 1][0] > tmp
  tmp = dp[i][2] + counts[i][1] + counts[i][2] + counts[i][3]
  dp[i + 1][0] = tmp if dp[i + 1][0] > tmp
  tmp = dp[i][0] + counts[i][0] + counts[i][2] + counts[i][3]
  dp[i + 1][1] = tmp if dp[i + 1][1] > tmp
  tmp = dp[i][2] + counts[i][0] + counts[i][2] + counts[i][3]
  dp[i + 1][1] = tmp if dp[i + 1][1] > tmp
  tmp = dp[i][0] + counts[i][0] + counts[i][1] + counts[i][3]
  dp[i + 1][2] = tmp if dp[i + 1][2] > tmp
  tmp = dp[i][1] + counts[i][0] + counts[i][1] + counts[i][3]
  dp[i + 1][2] = tmp if dp[i + 1][2] > tmp
end
p dp[n].min