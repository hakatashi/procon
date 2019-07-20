gets
ais = STDIN.gets_to_end.split.map(&.to_u64)
maxes = Array(UInt64).new
ais.each do |a|
  if maxes.size == 0 || maxes.last >= a
    maxes << a
  else
    i = maxes.bsearch_index {|max| max < a}
    unless i.nil?
      maxes[i] = a
    end
  end
end
puts maxes.size
