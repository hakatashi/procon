:function Gcd(a, b)
  :return a:b == 0 ? a:a : Gcd(a:b, a:a % a:b)
:endfunction
:normal "ndw"qdd"add"sdd
:let as = split(@a, ' ')
:let ps = [0]
:let gs = [as[0]]
:let gl = 1
:let x = str2nr(as[0])
:for i in range(1, @n - 1)
  :let n = Gcd(x, as[i])
  :if n != x
    :call add(ps, i)
    :call add(gs, n)
    :let gl += 1
    :let x = n
  :endif
:endfor
:for s in split(@s, ' ')
  :let l = 0
  :let h = gl - 1
  :while l <= h
    :let m = (l + h) / 2
    :let g = Gcd(gs[m], s)
    :if g == 1
      :let h = m - 1
    :else
      :let l = m + 1
    :endif
  :endwhile
  :if l < gl
    :put = ps[l] + 1
  :else
    :put = g
  :endif
:endfor
:1delete
:wq
