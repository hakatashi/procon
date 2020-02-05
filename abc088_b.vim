:ec contest: language-test-202001
:normal "ndd
:s/ /\r/g
:sort! n
:let r = 0
:normal gg
:for i in range(@n)
  :normal "add
  :let r += i % 2 ? -@a :@a
:endfor
:put! = r
:wq
