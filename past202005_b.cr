# -*- contest: past202005-open -*-

n, m, q = read_line.split.map(&.to_i64)
sets = Array(Set(Int64)).new(m) { Set(Int64).new }
q.times do
  tokens = read_line.split.map(&.to_i64)

  if tokens[0] == 1
    _, sn = tokens
    ans = 0_i64
    sets.map do |set|
      if set.includes?(sn - 1)
        ans += n - set.size
      end
    end
    p ans
  else
    _, sn, sm = tokens
    sets[sm - 1] << sn - 1
  end
end