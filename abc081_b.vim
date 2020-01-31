"ndd:let i=0
:let r=99
:wh i<@n
norm! "adw
let j=0
let a=@a
wh a%2==0
let a=a/2
let j+=1
endw
let r=r>j?j:r
let i+=1
endw
:exe append(0,r)
ddZZ