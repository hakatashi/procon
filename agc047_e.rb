puts "39362"

$ptr = 3

def add(a, b)
  tmp = $ptr
  puts "+ #{a} #{b} #{tmp}"
  $ptr += 1
  tmp
end

def addmov(a, b)
  puts "+ #{a} #{b} #{a}"
end

def gt(a, b)
  tmp = $ptr
  puts "< #{a} #{b} #{tmp}"
  $ptr += 1
  tmp
end

def _and(a, b)
  gt(gt(a, b), b)
end

def _or(a, b)
  add(gt(a, b), a)
end

def _not(a)
  gt(a, $one)
end

def xor(a, b)
  _or(_and(_not(a), b), _and(a, _not(b)))
end

def _if(a, v)
  tmp = add($zero, $zero)
  n = a
  r = v
  until r == 0
    if r % 2 == 1
      tmp = add(tmp, n)
    end
    n = add(n, n)
    r /= 2
  end
  tmp
end

a = 0
b = 1
$zero = gt(0, 2)
$one = gt(2, 0)

pow2 = [$one]
32.times do |i|
  pow2 << add(pow2.last, pow2.last)
end

pow2m1 = [$zero]
32.times do |i|
  pow2m1 << add(add(pow2m1.last, pow2m1.last), $one)
end

a_bits = []
ret = $zero
31.downto(0) do |i|
  bit = gt(add(ret, pow2m1[i]), a)
  ret = add(ret, _if(bit, 2 ** i))
  a_bits << bit
end
a_bits.reverse!

b_bits = []
ret = $zero
31.downto(0) do |i|
  bit = gt(add(ret, pow2m1[i]), b)
  ret = add(ret, _if(bit, 2 ** i))
  b_bits << bit
end
b_bits.reverse!

32.times do |ai|
  32.times do |bi|
    addmov(2, _if(_and(a_bits[ai], b_bits[bi]), 2 ** (ai + bi)))
  end
end

