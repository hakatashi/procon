# -*- contest: past202005-open -*-

n = read_line.to_i64
q = read_line.to_i64
rows = (0_i64...n).to_a
columns = (0_i64...n).to_a
transposed = false
q.times do
  tokens = read_line.split.map(&.to_i64)
  if tokens[0] == 1
    _, a, b = tokens
    rows[a - 1], rows[b - 1] = rows[b - 1], rows[a - 1]
  elsif tokens[0] == 2
    _, a, b = tokens
    columns[a - 1], columns[b - 1] = columns[b - 1], columns[a - 1]
  elsif tokens[0] == 3
    rows, columns = columns, rows
    transposed = !transposed
  else
    _, a, b = tokens
    if transposed
      p columns[b - 1] * n + rows[a - 1]
    else
      p rows[a - 1] * n + columns[b - 1]
    end
  end
end
