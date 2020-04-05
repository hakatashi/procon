# -*- status: skip -*-

boards = [
  [] of String,
  [] of String,
  [] of String,
  [
    "acc",
    "a.d",
    "bbd",
  ],
  [
    "abcc",
    "abdd",
    "eegh",
    "ffgh",
  ],
  [
    "abbcc",
    "ad..e",
    "fd..e",
    "f.ggh",
    "iijjh",
  ],
  [
    "acca..",
    "a.da..",
    "bbd.bb",
    "cc.acc",
    "..da.d",
    "..dbbd",
  ],
  [
    "aabbcc.",
    "ddee..f",
    "gghh..f",
    "....ijk",
    "....ijk",
    "....lmn",
    "....lmn",
  ],
  [
    "abcc....",
    "abdd....",
    "eegh....",
    "ffgh....",
    "....abcc",
    "....abdd",
    "....eegh",
    "....ffgh",
  ],
  [
    "acca.....",
    "a.da.....",
    "bbd.bb...",
    "...acca..",
    "...a.da..",
    "...bbd.bb",
    "a.....acc",
    "a.....a.d",
    ".bb...bbd",
  ],
]

n = read_line.to_i
if n == 2
  p -1
  exit
end

if n == 3 || n == 4 || n == 5
  n.times do |i|
    puts boards[n][i]
  end
  exit
end

step_size = (n - 6) // 4 * 4
n.times do |i|
  if i < step_size
    step = i // 4
    puts "." * (step * 4) + boards[4][i % 4] + "." * (n - (step + 1) * 4)
  else
    puts "." * step_size + boards[n - step_size][i - step_size]
  end
end