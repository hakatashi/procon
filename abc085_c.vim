:ec contest: language-test-202001
:normal! "ndw"ydw
:for a in range(0, @n)
  :let money = @y - a * 10000
  :let cnt = str2nr(@n) - a
  :let b = str2float(money - 1000 * cnt) / 4000
  :let c = cnt - b
  :if b >= 0 && c >= 0 && fmod(b, 1) == 0
    :put! = a . ' ' . float2nr(b) . ' ' . float2nr(c)
    :wq
  :endif
:endfor
:put! = '-1 -1 -1'
:wq
