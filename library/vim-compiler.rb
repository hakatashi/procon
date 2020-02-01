require_relative 'keylog.rb'

unless ARGV.size == 2
  puts 'Usage: vim-compiler.rb <infile> <outfile>'
  exit 1
end
outfile = ARGV.pop

ARGF.binmode
compiled = ARGF.read.gsub(/\r\n/, "\n").gsub(/<.+?>/) do |seq|
  match = VimGolf::Keylog::KC_1BYTE.each_with_index.find {|v, i| !v.nil? && v.downcase == seq.downcase}
  unless match.nil?
    next String.new match[1].chr, encoding: Encoding::ASCII_8BIT
  end
  match = VimGolf::Keylog::KC_MBYTE.find {|_k, v| !v.nil? && v.downcase == seq.downcase}
  unless match.nil?
    next String.new "\x80#{match[0]}", encoding: Encoding::ASCII_8BIT
  end
  seq
end

File.binwrite(outfile, compiled)
