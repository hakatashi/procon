n, a, b, c = read_line.split.map(&.to_i64)
ss = [] of String
n.times do
  s = read_line
  ss << s
end

vs = [a, b, c]
names = ['A', 'B', 'C']
steps = [] of Char
if a + b + c != 2
  ss.each do |s|
    if s == "AB"
      i, j = 0, 1
    elsif s == "BC"
      i, j = 1, 2
    else
      i, j = 2, 0
    end
    if vs[i] == 0 && vs[j] == 0
      puts "No"
      exit
    else
      if vs[i] > vs[j]
        vs[i] -= 1
        vs[j] += 1
        steps << names[j]
      else
        vs[i] += 1
        vs[j] -= 1
        steps << names[i]
      end
    end
  end
  puts "Yes"
  steps.each do |step|
    puts step
  end
else
  dp = Array(Tuple(Bool, Bool, Bool, Bool, Bool, Bool)).new(n + 1) { {false, false, false, false, false, false} }
  states = [
    {2, 0, 0},
    {1, 1, 0},
    {1, 0, 1},
    {0, 2, 0},
    {0, 1, 1},
    {0, 0, 2},
  ]
  moves = {
    "AB" => 
  }
  if vs == [2, 0, 0]
    dp[0] = {true, false, false, false, false, false}
  elsif vs == [1, 1, 0]
    dp[0] = {false, true, false, false, false, false}
  elsif vs == [0, 2, 0]
    dp[0] = {false, false, true, false, false, false}
  elsif vs == [0, 1, 1]
    dp[0] = {false, false, false, true, false, false}
  elsif vs == [0, 0, 2]
    dp[0] = {false, false, false, false, true, false}
  elsif vs == [1, 0, 1]
    dp[0] = {false, false, false, false, false, true}
  end
  ss.each_with_index do |s, i|
    if s == "AB"
      dp[i + 1] = {
        dp[i][1],
        dp[i][0] | dp[i][2],
        dp[i][1],
        dp[i][5],
        false,
        dp[i][3],
      }
    elsif s == "BC"
      dp[i + 1] = {
        false,
        dp[i][5],
        dp[i][3],
        dp[i][2] | dp[i][4],
        dp[i][3],
        dp[i][1],
      }
    elsif s == "AC"
      dp[i + 1] = {
        dp[i][5],
        dp[i][3],
        false,
        dp[i][1],
        dp[i][5],
        dp[i][0] | dp[i][4],
      }
    end
  end
  if dp[n].all?(false)
    puts "No"
  else
    state = dp[n].index(true).not_nil!.to_i64
    (n - 1).downto(0) do |i|
      if ss[i] == "AB"
        if state == 1
          if dp[i][0]
            state = 0
            steps << 'B'
          else
            state = 2
            steps << 'A'
          end
        else
          steps << "AXBBXA"[state]
          state = [1, -1, 1, 5, -1, 3][state]
        end
      elsif ss[i] == "BC"
        if state == 3
          if dp[i][2]
            state = 2
            steps << 'C'
          else
            state = 4
            steps << 'B'
          end
        else
          steps << "XBBXCC"[state]
          state = [-1, 5, 3, -1, 3, 1][state]
        end
      elsif ss[i] == "AC"
        if state == 5
          if dp[i][0]
            state = 0
            steps << 'C'
          else
            state = 4
            steps << 'A'
          end
        else
          steps << "AAXCCX"[state]
          state = [5, 3, -1, 1, 5, -1][state]
        end
      end
    end
    puts "Yes"
    steps.reverse_each do |step|
      puts step
    end
  end
end