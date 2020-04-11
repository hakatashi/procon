:normal "ndd
:let reds = []
:let blues = []
:for i in range(@n)
  :normal "xdw"cdd
  :if @c == "R\n"
    :call add(reds, str2nr(@x))
  :else
    :call add(blues, str2nr(@x))
  :endif
:endfor
:for red in sort(reds, 'n')
  :put = red
:endfor
:for blue in sort(blues, 'n')
  :put = blue
:endfor
:1delete
:wq
