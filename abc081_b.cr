# -*- contest: language-test-202001 -*-

gets
p read_line.split.map { |a| a.to_i.to_s(2)[/0*$/].size }.min
