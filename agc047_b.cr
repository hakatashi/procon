n = read_line.to_i64
ss = [] of String
n.times do
  ss << read_line.reverse
end

class Trie
  property root : Node

  class Node
    property children : Array(Node?)
    property value : Char?
    property end_set : Int32

    def initialize(@value)
      @children = Array(Node?).new(26, nil)
      @end_set = 0_i32
    end
  end

  def initialize
    @root = Node.new(nil)
  end

  def insert(s : String, suffix : Char)
    node = @root
    s.chars.each do |c|
      i = c - 'a'
      if node.children[i].nil?
        node.children[i] = Node.new(c)
      end
      node = node.children[i].not_nil!
    end
    node.end_set |= (1 << (suffix - 'a'))
  end
end

trie = Trie.new
ss.each do |s|
  trie.insert(s[...-1], s[-1])
end

def dfs(node, end_set)
  node.children.each_with_index do |child, i|
    next if child.nil?
    26.times do |j|
      if ((child.end_set >> j) & 1) != 0
        end_set[i] += 1
      end
    end
  end
end

dfs(trie.root, [0] * 26)