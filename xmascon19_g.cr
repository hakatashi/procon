points = [] of Tuple(Int32, Int32)
pres_sets = Array(Set(Int32)).new(58) { Set(Int32).new }
h, w = read_line.split.map(&.to_i)
h.times do |y|
  read_line.chars.each_with_index do |c, x|
    if c == '.'
      left = (x + y * 17) % 29
      right = (x + y * 12) % 29 + 29
      pres_sets[left] << right
      pres_sets[right] << left
    end
  end
end
pres = pres_sets.map(&.to_a)
matching = Array(Int32).new(58, -1)
found = 0
ans = 0
until found == -1
  found = -1
  29.times do |i|
    next if matching[i] != -1
    prevs = Array(Int32).new(58, -1)
    visited = Set(Int32).new
    visited << i
    queue = Deque(Int32).new
    queue << i
    until queue.empty?
      node = queue.shift
      if node < 29
        pres[node].each do |pre|
          unless visited.includes?(pre)
            visited << pre
            queue << pre
            prevs[pre] = node
          end
        end
      else
        if matching[node] == -1
          found = node
          break
        else
          unless visited.includes?(matching[node])
            visited << matching[node]
            queue << matching[node]
            prevs[matching[node]] = node
          end
        end
      end
    end
    if found != -1
      node = found
      until node == i
        if node >= 29
          matching[node] = prevs[node]
          matching[prevs[node]] = node
        end
        node = prevs[node]
      end
      ans += 1
      break
    end
  end
end
p ans