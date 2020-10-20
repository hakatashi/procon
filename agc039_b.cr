n = read_line.to_i
sss = [] of Set(Int32)
n.times do
  ss = Set(Int32).new
  read_line.chars.each_with_index do |c, i|
    if c == '1'
      ss << i
    end
  end
  sss << ss
end
colors = Array(Bool | Nil).new(n, nil)

def dfs(sss, colors, index)
  new_color = !colors[index]
  sss[index].each do |preceding|
    if colors[preceding] == nil
      colors[preceding] = new_color
      result = dfs(sss, colors, preceding)
      if result == false
        return false
      end
    elsif colors[preceding] != new_color
      return false
    end
  end
  return true
end

colors[0] = true
result = dfs(sss, colors, 0)
if result == false
  puts -1
  exit
end
diameter = 0
n.times do |i|
  visited = Set{i}
  siblings = Set{i}
  depth = 1
  while visited.size != n
    new_siblings = Set(Int32).new
    siblings.each do |node|
      sss[node].each do |preceding|
        next if visited.includes? preceding
        visited << preceding
        new_siblings << preceding
      end
    end
    siblings = new_siblings
    depth += 1
  end
  diameter = [diameter, depth].max
end
p diameter
