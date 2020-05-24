n = read_line.to_i64
if [2, 4, 5, 7, 9].includes? n % 10
  puts "hon"
elsif n % 10 == 3
  puts "bon"
else
  puts "pon"
end
