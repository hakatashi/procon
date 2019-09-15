n = read_line.to_i
aiss = [] of Array(Int32)
n.times do
  ais = read_line.split.map do |t|
    t.to_i - 1
  end
  aiss << ais
end

matches = Set(Int32).new
match_counterparts = Set(Int32).new
aiss.each_with_index do |ais, i|
  if aiss[ais.first].first == i && !match_counterparts.includes?(i)
    matches << i
    match_counterparts << ais.first
  end
end

ret = 0
while matches.size > 0
  new_matches = Set(Int32).new
  new_match_counterparts = Set(Int32).new
  processed = Set(Int32).new
  matches.each do |match|
    counterpart = aiss[match].first
    aiss[match].shift
    aiss[counterpart].shift
    processed << match
    processed << counterpart

    if aiss[match].size > 0 && (processed.includes?(aiss[match].first) || (!matches.includes?(aiss[match].first) && !match_counterparts.includes?(aiss[match].first)))
      cp = aiss[match].first
      if aiss[cp].size > 0 && aiss[cp].first == match && !new_matches.includes?(cp) && !new_match_counterparts.includes?(cp)
        new_matches << match
        new_match_counterparts << cp
      end
    end

    if aiss[counterpart].size > 0 && (processed.includes?(aiss[counterpart].first) || (!matches.includes?(aiss[counterpart].first) && !match_counterparts.includes?(aiss[counterpart].first)))
      cp = aiss[counterpart].first
      if aiss[cp].size > 0 && aiss[cp].first == counterpart && !new_matches.includes?(cp) && !new_match_counterparts.includes?(cp)
        new_matches << counterpart
        new_match_counterparts << cp
      end
    end
  end

  matches = new_matches
  match_counterparts = new_match_counterparts

  ret += 1
end

if aiss.any? {|ais| ais.size > 0}
  puts "-1"
else
  puts ret
end