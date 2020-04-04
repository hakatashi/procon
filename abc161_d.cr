k = read_line.to_i64

class Dfs
  def initialize(@k : Int64)
    @cnt = 0_i64
    dfs(1_i64, 0_i64)
  end
  def dfs(len, acc)
    if len == 11
      @cnt += 1
      if @cnt == @k + 1
        p acc
        exit
      end
      return
    end
    digit = acc % 10
    if acc == 0
      10_i64.times do |d|
        dfs(len + 1, d)
      end
    else
      if digit - 1 >= 0
        dfs(len + 1, acc * 10 + digit - 1)
      end
      dfs(len + 1, acc * 10 + digit)
      if digit + 1 < 10
        dfs(len + 1, acc * 10 + digit + 1)
      end
    end
  end
end

Dfs.new(k)