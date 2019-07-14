n = read_line.to_u64
if n.to_s(2).chars.count('1') == 1
  puts "No"
  exit
end

puts "Yes"

if n % 2 == 1
  puts "3 #{n + 1}"
  (2..n).step(2).each do |i|
    puts "#{n + i} #{n + i + 1}"
    puts "#{n + i + 1} 1"
    puts "1 #{i}"
    puts "#{i} #{i + 1}"
  end
else
  puts "3 #{n + 1}"
  (2..(n - 4)).step(2).each do |i|
    puts "#{n + i} #{n + i + 1}"
    puts "#{n + i + 1} 1"
    puts "1 #{i}"
    puts "#{i} #{i + 1}"
  end
  target = n ^ (n - 2)
  puts "#{target} #{n - 2}"
  puts "#{n - 2} #{n - 1}"
  puts "#{2 * n - 2} #{2 * n - 1}"
  puts "#{2 * n - 1} #{target + 1}"
  puts "#{n} #{target}"
  puts "#{n - 2} #{2 * n}"
end
