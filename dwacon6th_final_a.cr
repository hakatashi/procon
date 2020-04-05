# contest: dwacon6th-final-open

h, w = read_line.split.map(&.to_i64)
if h == 1
  if w % 7 == 0
    puts [
      "Yes",
      "2255555" * (w // 7),
    ].join("\n")
  elsif w % 7 == 2
    puts [
      "Yes",
      "2255555" * (w // 7) + "22",
    ].join("\n")
  elsif w % 7 == 5
    puts [
      "Yes",
      "5555522" * (w // 7) + "55555",
    ].join("\n")
  else
    puts "No"
  end
elsif h == 2
  if w % 7 == 0
    puts [
      "Yes",
      "5552552" * (w // 7),
      "5525552" * (w // 7),
    ].join("\n")
  elsif w % 7 == 1
    puts [
      "Yes",
      "2555255" * (w // 7) + "2",
      "2552555" * (w // 7) + "2",
    ].join("\n")
  elsif w % 7 == 6
    puts [
      "Yes",
      "5552552" * (w // 7) + "555255",
      "5525552" * (w // 7) + "552555",
    ].join("\n")
  else
    puts "No"
  end
elsif w == 1
  if h % 7 == 0
    puts (["Yes"] + ["5", "5", "5", "5", "5", "2", "2"] * (h // 7)).join("\n")
  elsif h % 7 == 2
    puts (["Yes"] + ["2", "2", "5", "5", "5", "5", "5"] * (h // 7) + ["2", "2"]).join("\n")
  elsif h % 7 == 5
    puts (["Yes"] + ["5", "5", "5", "5", "5", "2", "2"] * (h // 7) + ["5", "5", "5", "5", "5"]).join("\n")
  else
    puts "No"
  end
elsif w == 2
  if h % 7 == 0
    puts ([
      "Yes",
    ] + [
      "55",
      "55",
      "52",
      "25",
      "55",
      "55",
      "22",
    ] * (h // 7)).join("\n")
  elsif h % 7 == 1
    puts ([
      "Yes",
    ] + [
      "22",
      "55",
      "55",
      "52",
      "25",
      "55",
      "55",
    ] * (h // 7) + [
      "22",
    ]).join("\n")
  elsif h % 7 == 6
    puts ([
      "Yes",
    ] + [
      "55",
      "55",
      "52",
      "25",
      "55",
      "55",
      "22",
    ] * (h // 7) + [
      "55",
      "55",
      "52",
      "25",
      "55",
      "55",
    ]).join("\n")
  else
    puts "No"
  end
elsif h == 3 && w == 3
  puts [
    "Yes",
    "552",
    "252",
    "255",
  ].join("\n")
else
  puts "No"
end