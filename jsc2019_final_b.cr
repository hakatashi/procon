# -*- contest: jsc2019-final-open -*-

require "big"

n = read_line.to_i
aiss = [] of BigInt
bss = [] of BigInt

n.times do
  aiss << BigInt.new(read_line.reverse, base: 2)
end
n.times do
  bss << BigInt.new(read_line.reverse, base: 2)
end

css = Array(BigInt).new(n) { BigInt.new("1" * n, base: 2) }

aiss.each_with_index do |ais, i|
  n.times do |j|
    if ((ais >> j) & 1) != 0
      css[j] = css[j] & bss[i]
    end
  end
end

bss.each_with_index do |bs, i|
  n.times do |j|
    if ((bs >> j) & 1) != 0
      pass = false
      n.times do |k|
        if ((aiss[i] >> k) & (css[k] >> j) & 1) != 0
          pass = true
          break
        end
      end
      unless pass
        p -1
        exit
      end
    end
  end
end

css.each do |cs|
  puts cs.to_s(2).rjust(n, '0').reverse
end
