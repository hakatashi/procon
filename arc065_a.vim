:g/\v^(dream|dreamer|erase|eraser)*$/normal D
:put! = @\" == '' ? 'NO' : 'YES'
:normal jdd
:wq
