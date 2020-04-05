# -*- status: pending -*-

# bench_red_black_tree.rb by Rubinius Project, (c) Rubinius Contributors
# https://github.com/rubinius/rubinius-benchmark/blob/master/real_world/bench_red_black_tree.rb
# Licensed under BSD License

# red_black_tree.cr by Crystal Language Project, (c) Manas Technology Solutions
# https://github.com/crystal-lang/crystal/blob/master/samples/red_black_tree.cr
# Licensed under MIT License

# RedBlackTree.cr by Koki Takahashi
# Licensed under MIT License

class RedBlackTree
  class Node
    property :color
    property :key
    property! :left
    property! :right
    property! parent : self

    RED   = :red
    BLACK = :black

    def initialize(@key : Int32, @color = RED)
      @left = @right = @parent = NilNode.instance
    end

    def black?
      color == BLACK
    end

    def red?
      color == RED
    end

    def nil_node?
      false
    end
  end

  class NilNode < Node
    def self.instance
      @@instance ||= RedBlackTree::NilNode.new
    end

    def initialize
      @key = 0
      @color = BLACK
      @left = @right = @parent = self
    end

    def nil_node?
      true
    end
  end

  property root : Node
  property :size

  def initialize
    @root = NilNode.instance
    @size = 0
  end

  def insert(key)
    insert_node(Node.new(key))
  end

  def insert_node(x)
    insert_helper(x)

    x.color = Node::RED
    while x != root && x.parent.color == Node::RED
      if x.parent == x.parent.parent.left
        y = x.parent.parent.right
        if !y.nil_node? && y.color == Node::RED
          x.parent.color = Node::BLACK
          y.color = Node::BLACK
          x.parent.parent.color = Node::RED
          x = x.parent.parent
        else
          if x == x.parent.right
            x = x.parent
            left_rotate(x)
          end
          x.parent.color = Node::BLACK
          x.parent.parent.color = Node::RED
          right_rotate(x.parent.parent)
        end
      else
        y = x.parent.parent.left
        if !y.nil_node? && y.color == Node::RED
          x.parent.color = Node::BLACK
          y.color = Node::BLACK
          x.parent.parent.color = Node::RED
          x = x.parent.parent
        else
          if x == x.parent.left
            x = x.parent
            right_rotate(x)
          end
          x.parent.color = Node::BLACK
          x.parent.parent.color = Node::RED
          left_rotate(x.parent.parent)
        end
      end
    end
    root.color = Node::BLACK
  end

  def delete_node(z)
    y = (z.left.nil_node? || z.right.nil_node?) ? z : successor(z)
    x = y.left.nil_node? ? y.right : y.left
    x.parent = y.parent

    if y.parent.nil_node?
      self.root = x
    else
      if y == y.parent.left
        y.parent.left = x
      else
        y.parent.right = x
      end
    end

    z.key = y.key if y != z

    if y.color == Node::BLACK
      delete_fixup(x)
    end

    self.size -= 1
    y
  end

  def minimum_node(x = root)
    while !x.left.nil_node?
      x = x.left
    end
    x
  end

  def maximum_node(x = root)
    while !x.right.nil_node?
      x = x.right
    end
    x
  end

  def successor(x)
    if !x.right.nil_node?
      return minimum_node(x.right)
    end
    y = x.parent
    while !y.nil_node? && x == y.right
      x = y
      y = y.parent
    end
    y
  end

  def predecessor(x)
    if !x.left.nil_node?
      return maximum_node(x.left)
    end
    y = x.parent
    while !y.nil_node? && x == y.left
      x = y
      y = y.parent
    end
    y
  end

  def inorder_walk(x = root)
    x = self.minimum_node
    while !x.nil_node?
      yield x.key
      x = successor(x)
    end
  end

  def each(x = root)
    inorder_walk(x) { |k| yield k }
  end

  def reverse_inorder_walk(x = root)
    x = self.maximum_node
    while !x.nil_node?
      yield x.key
      x = predecessor(x)
    end
  end

  def reverse_each(x = root)
    reverse_inorder_walk(x) { |k| yield k }
  end

  def search(key, x = root)
    while !x.nil_node? && x.key != key
      x = (key < x.key) ? x.left : x.right
    end
    x
  end

  def empty?
    self.root.nil_node?
  end

  def black_height(x = root)
    height = 0
    while !x.nil_node?
      x = x.left
      height += 1 if x.nil_node? || x.black?
    end
    height
  end

  private def left_rotate(x)
    raise "x.right is nil!" if x.right.nil_node?
    y = x.right
    x.right = y.left
    y.left.parent = x if !y.left.nil_node?
    y.parent = x.parent
    if x.parent.nil_node?
      self.root = y
    else
      if x == x.parent.left
        x.parent.left = y
      else
        x.parent.right = y
      end
    end
    y.left = x
    x.parent = y
  end

  private def right_rotate(x)
    raise "x.left is nil!" if x.left.nil_node?
    y = x.left
    x.left = y.right
    y.right.parent = x if !y.right.nil_node?
    y.parent = x.parent
    if x.parent.nil_node?
      self.root = y
    else
      if x == x.parent.left
        x.parent.left = y
      else
        x.parent.right = y
      end
    end
    y.right = x
    x.parent = y
  end

  private def insert_helper(z)
    y = NilNode.instance
    x = root
    while !x.nil_node?
      y = x
      x = (z.key < x.key) ? x.left : x.right
    end
    z.parent = y
    if y.nil_node?
      self.root = z
    else
      z.key < y.key ? y.left = z : y.right = z
    end
    self.size += 1
  end

  private def delete_fixup(x)
    while x != root && x.color == Node::BLACK
      if x == x.parent.left
        w = x.parent.right
        if w.color == Node::RED
          w.color = Node::BLACK
          x.parent.color = Node::RED
          left_rotate(x.parent)
          w = x.parent.right
        end
        if w.left.color == Node::BLACK && w.right.color == Node::BLACK
          w.color = Node::RED
          x = x.parent
        else
          if w.right.color == Node::BLACK
            w.left.color = Node::BLACK
            w.color = Node::RED
            right_rotate(w)
            w = x.parent.right
          end
          w.color = x.parent.color
          x.parent.color = Node::BLACK
          w.right.color = Node::BLACK
          left_rotate(x.parent)
          x = root
        end
      else
        w = x.parent.left
        if w.color == Node::RED
          w.color = Node::BLACK
          x.parent.color = Node::RED
          right_rotate(x.parent)
          w = x.parent.left
        end
        if w.right.color == Node::BLACK && w.left.color == Node::BLACK
          w.color = Node::RED
          x = x.parent
        else
          if w.left.color == Node::BLACK
            w.right.color = Node::BLACK
            w.color = Node::RED
            left_rotate(w)
            w = x.parent.left
          end
          w.color = x.parent.color
          x.parent.color = Node::BLACK
          w.left.color = Node::BLACK
          right_rotate(x.parent)
          x = root
        end
      end
    end
    x.color = Node::BLACK
  end

  def min
    minimum_node.key
  end

  def max
    maximum_node.key
  end

  def delete(key)
    node = search(key)
    unless node.nil_node?
      delete_node(node)
    end
  end

  def has_key?(key)
    node = search(key)
    !node.nil_node?
  end

  def <<(x)
    insert(x)
  end
end

# PriorityQueue.cr by Koki Takahashi
# Licensed under MIT License

class PriorityQueue(T)
  property heap : Array(T)

  def initialize
    initialize(&.itself)
  end

  def initialize(&block : T -> (Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64))
    @heap = Array(T).new
    @priority_proc = block
  end

  def push(v : T)
    @heap << v
    index = @heap.size - 1
    while index != 0
      parent = (index - 1) // 2
      if @priority_proc.call(@heap[parent]) >= @priority_proc.call(@heap[index])
        break
      end
      @heap[parent], @heap[index] = @heap[index], @heap[parent]
      index = parent
    end
  end

  def <<(v : T)
    push(v)
  end

  def pop
    if @heap.size == 0
      return nil
    end
    if @heap.size == 1
      return @heap.pop
    end
    ret = @heap.first
    @heap[0] = @heap.pop
    index = 0
    while index * 2 + 1 < @heap.size
      child = if index * 2 + 2 < @heap.size && @priority_proc.call(@heap[index * 2 + 1]) < @priority_proc.call(@heap[index * 2 + 2])
        index * 2 + 2
      else
        index * 2 + 1
      end
      if @priority_proc.call(@heap[index]) >= @priority_proc.call(@heap[child])
        break
      end
      @heap[child], @heap[index] = @heap[index], @heap[child]
      index = child
    end
    ret
  end

  def top
    @heap.first
  end

  delegate :empty?, to: @heap
end

def min(a, b)
  a > b ? b : a
end

def max(a, b)
  a > b ? a : b
end

h, w, k = read_line.split.map(&.to_i64)
board = Array(Array(Bool)).new(w) { Array(Bool).new(h, true) }
k.times do
  a, b = read_line.split.map(&.to_i64)
  board[b - 1][a - 1] = false
end

left_verticals = Array(Array(Int64)).new(w) { Array(Int64).new(h, 0_i64) }
left_diagonals = Array(Array(Int64)).new(w) { Array(Int64).new(h, 0_i64) }
lefts = Array(Array(Int64)).new(w) { Array(Int64).new(h, 0_i64) }
right_verticals = Array(Array(Int64)).new(w) { Array(Int64).new(h, 0_i64) }
right_diagonals = Array(Array(Int64)).new(w) { Array(Int64).new(h, 0_i64) }
rights = Array(Array(Int64)).new(w) { Array(Int64).new(h, 0_i64) }

w.times do |x|
  sum = 0_i64
  h.times do |y|
    if board[x][y] == true
      sum += 1
      right_verticals[x][y] = sum
    else
      sum = 0_i64
    end
  end

  sum = 0_i64
  h.times do |ry|
    y = h - ry - 1
    if board[x][y] == true
      sum += 1
      left_verticals[x][y] = sum
    else
      sum = 0_i64
    end
  end
end

(-h + 1).upto(w - 1) do |i|
  sum = 0_i64
  max(0, -i).upto(min(h - 1, h - i - 1)) do |y|
    x = i + y
    if board[x][y] == true
      sum += 1
      right_diagonals[x][y] = sum
    else
      sum = 0_i64
    end
  end

  sum = 0_i64
  min(h - 1, h - i - 1).downto(max(0, -i)) do |y|
    x = i + y
    if board[x][y] == true
      sum += 1
      left_diagonals[x][y] = sum
    else
      sum = 0_i64
    end
  end
end

w.times do |x|
  h.times do |y|
    lefts[x][y] = min(left_verticals[x][y], left_diagonals[x][y])
    rights[x][y] = min(right_verticals[x][y], right_diagonals[x][y])
  end
end

ans = 0_i64

(-h + 1).upto(w - 1) do |i|
  sum = 0_i64
  infos = [] of Tuple(Int64, Int64, Int64)
  sorted_lefts = [1_i64 << 60]
  left_vals = [] of Int64
  max(0, -i).upto(min(h - 1, h - i - 1)).each do |y|
    x = i + y
    left = lefts[x][y]
    index = sorted_lefts.bsearch_index {|left2| left2 >= a} .not_nil!.to_i64
    rights.unshift(index)
    sorted_ais.insert(index, a)
  end
end
