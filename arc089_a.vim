:norm! "ndd
:let ct = 0
:let cx = 0
:let cy = 0
:let ok = 1
:for i in range(@n)
  :norm! "tdw"xdw"ydd
  :let distance = abs(@x - cx) + abs(@y - cy)
  :let parity = (distance + @t - ct) % 2
  :if parity == 1 || distance > @t - ct
    :let ok = 0
  :endif
  :let ct = @t
  :let cx = @x
  :let cy = @y
:endfor
:put! = ok ? 'Yes' : 'No'
:norm! jdd
:wq
