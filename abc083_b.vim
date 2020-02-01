:ec contest: language-test-202001
:normal! "ndw"adw"bdw
:let a = 0
:for i in range(1, @n)
  :let n = eval(substitute(i, ".", "+&", "g"))
  :let a += @a <= n && n <= @b ? i : 0
:endfor
:put! = a
:wq
