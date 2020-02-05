:ec contest: language-test-202001
:normal "ndd
:let r = 99
:for i in range(@n)
  :normal "adw
  :let j = 0
  :let a = @a
  :while a % 2 == 0
    :let a = a / 2
    :let j += 1
  :endwhile
  :let r = r > j ? j : r
:endfor
:put! = r
:wq
