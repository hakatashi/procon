"ndd:s/ /\r/g
:sor!n
:let i=0
:let r=0
gg:wh i<@n
norm! "add
let r+=i%2?-@a:@a
let i+=1
endw
:pu!=r
ddZZ