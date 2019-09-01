gets
STDIN.each_line do |line|
  if line =~ /^.*okyo.*ech.*$/
    puts "Yes"
  else
    puts "No"
  end
end
