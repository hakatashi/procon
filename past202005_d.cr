# -*- contest: past202005-open -*-

DIGITS = [
  [
    "###",
    "#.#",
    "#.#",
    "#.#",
    "###",
  ],
  [
    ".#.",
    "##.",
    ".#.",
    ".#.",
    "###",
  ],
  [
    "###",
    "..#",
    "###",
    "#..",
    "###",
  ],
  [
    "###",
    "..#",
    "###",
    "..#",
    "###",
  ],
  [
    "#.#",
    "#.#",
    "###",
    "..#",
    "..#",
  ],
  [
    "###",
    "#..",
    "###",
    "..#",
    "###",
  ],
  [
    "###",
    "#..",
    "###",
    "#.#",
    "###",
  ],
  [
    "###",
    "..#",
    "..#",
    "..#",
    "..#",
  ],
  [
    "###",
    "#.#",
    "###",
    "#.#",
    "###",
  ],
  [
    "###",
    "#.#",
    "###",
    "..#",
    "###",
  ],
]

n = read_line.to_i64
digits = Array(Array(String)).new(n) { [] of String }
5.times do
  line = read_line
  line.chars.each_slice(4, true).with_index do |s, i|
    if s.size == 4
      digits[i] << s[1..].join
    end
  end
end

ans = digits.map do |digit|
  DIGITS.index(digit).not_nil!.to_s
end.join
puts ans
