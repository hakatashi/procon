$queries = []

$ptr = 3

def add(a, b)
  tmp = $ptr
  $queries << "+ #{a} #{b} #{tmp}"
  $ptr += 1
  tmp
end

def addmov(a, b)
  $queries << "+ #{a} #{b} #{a}"
end

def gt(a, b)
  tmp = $ptr
  $queries << "< #{a} #{b} #{tmp}"
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

pow2m1 = [$zero]
30.times do |i|
  pow2m1 << add(add(pow2m1.last, pow2m1.last), $one)
end

a_bits = []
ret = $zero
29.downto(0) do |i|
  bit = gt(add(ret, pow2m1[i]), a)
  ret = add(ret, _if(bit, 2 ** i))
  a_bits << bit
end
a_bits.reverse!

b_bits = []
ret = $zero
29.downto(0) do |i|
  bit = gt(add(ret, pow2m1[i]), b)
  ret = add(ret, _if(bit, 2 ** i))
  b_bits << bit
end
b_bits.reverse!

c_bits = []
60.times do
  c_bits << $ptr
  $ptr += 1
end

30.times do |ai|
  30.times do |bi|
    addmov(c_bits[ai + bi], _and(a_bits[ai], b_bits[bi]))
  end
end

ret = $zero
c_bits.reverse_each do |c_bit|
  ret = add(ret, ret)
  ret = add(ret, c_bit)
end

addmov(2, ret)


p $queries.size
$queries.each do |query|
  puts query
end
