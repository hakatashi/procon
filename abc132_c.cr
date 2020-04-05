gets
ds = read_line.split(" ").map(&.to_i)
ds.sort!
a = ds[ds.size // 2 - 1]
b = ds[ds.size // 2]
puts b - a
