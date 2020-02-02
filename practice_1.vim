:delete a
:delete f
:delete s
:let a = @a
:let b = split(@f)[0]
:let c = split(@f)[1]
:let s = @s
:put! = (a + b + c) . ' ' . s
:join!
:write
:quit
