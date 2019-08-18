gets
ret = read_line.split.map(&.to_f).map {|a| 1.0 / a} .sum
printf("%.5f\n", 1.0 / ret)