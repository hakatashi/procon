:ec contest: language-test-202001
:normal! "add"bdd"cdd"xdd
:let a = 0
:for i in range(0, @a)
  :for j in range(0, @b)
    :for k in range(0, @c)
      :let a += i * 500 + j * 100 + k * 50 == @x ? 1 : 0
    :endfor
  :endfor
:endfor
:put! = a
:wq
