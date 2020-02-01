require_relative 'keylog.rb'

ARGF.binmode
compiled = ARGF.read.gsub(/\r\n/, "\n").gsub(/<.+?>/) do |seq|
  match = VimGolf::Keylog::KC_MBYTE.find {|_k, v| !v.nil? && v.downcase == seq.downcase}
  unless match.nil?
    next String.new "\x80#{match[0]}", encoding: Encoding::ASCII_8BIT
  end
  match = VimGolf::Keylog::KC_1BYTE.each_with_index.find {|v, i| !v.nil? && v.downcase == seq.downcase}
  unless match.nil?
    next String.new match[1].chr, encoding: Encoding::ASCII_8BIT
  end
  seq
end

outfile = if ARGF.filename.end_with?('.vim')
  ARGF.filename.sub(/\.vim$/, '.compiled.vim')
else
  ARGF.filename + '.compiled.vim'
end

File.binwrite(outfile, compiled)
