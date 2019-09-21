class AVLtree
  class Node
    property bal : Int32, left : Node?, data : UInt64, right : Node?

    def initialize(bal, left, data, right)
      @bal, @left, @data, @right = bal, left, data, right
    end

    def inspect
      "(%s %s %s)" % [@left.inspect, @data.inspect, @right.inspect]
    end

    def min
      if @left.nil?
        @data
      else
        @left.not_nil!.min
      end
    end

    def max
      if @right.nil?
        @data
      else
        @right.not_nil!.max
      end
    end
  end

  def inspect() @root.inspect end

  property root : Node?

  def initialize(root = nil)
    @root = root
  end

  def insert(x)
    child = Node.new(0, nil, x, nil)
    return self.tap{ @root = child } if @root.nil?
    path = [] of Node
    node = @root
    while !node.nil?
      return self if x == node.data
      path.push node
      if x < node.data
        node = node.left
      else
        node = node.right
      end
    end
    path.push child
    parent = path[-2]
    if x < parent.data
      parent.left = child
    else
      parent.right = child
    end
    balance(path, :insert)
    self
  end

  def delete(x)
    return self if @root.nil?
    path = [] of Node
    just, node = nil, @root
    while !node.nil?
      if x == node.data
        just = node
      end
      path.push node
      if x <= node.data
        node = node.left
      else
        node = node.right
      end
    end
    return self if just.nil?
    node = path[-1]     # path = [..., parent, node]
    parent = path.size >= 2 ? path[-2] : nil
    if !just == node
      just.data = node.data
    end
    child = node.right.nil? ? node.left : node.right
    if parent.nil?
      @root = child
    elsif parent.left == node
      parent.left = child
    else
      parent.right = child
    end
    if child.nil?
      path.pop
    else
      path[-1] = child
    end
    balance(path, :delete)
    self
  end

  def min
    @root.not_nil!.min
  end

  def max
    @root.not_nil!.max
  end

  # based on csh/sh.set.c 5.2 (Berkeley) 1985-06-06
  # see http://minnie.tuhs.org/cgi-bin/utree.pl?file=4.3BSD/usr/src/bin/csh/sh.set.c

  def balance(path, d)
    path.each_cons(2).to_a.reverse_each do |(n, t)|
      if (d == :delete) ^ (n.right == t)
        balance_right_heavy(n)
      else
        balance_left_heavy(n)
      end
      break if (d == :delete) ^ (n.bal == 0)
    end
  end

  def balance_right_heavy(n)
    if n.bal == 0
      n.bal = +1
    elsif n.bal < 0 || n.right.nil?
      n.bal =  0
    else  # was right heavy
      case n.right.not_nil!.bal
      when +1
        rotate_left(n)
        n.left.not_nil!.bal = 0
        n.bal = 0
      when  0
        rotate_left(n)
        n.left.not_nil!.bal = +1
        n.bal = -1
      when -1
        b = n.right.not_nil!.left.not_nil!.bal
        rotate_right(n.right.not_nil!)
        rotate_left(n)
        n.left.not_nil!.bal  = b > 0 ? -1 : 0 
        n.right.not_nil!.bal = b < 0 ? +1 : 0 
        n.bal = 0
      end
    end
  end

  def balance_left_heavy(n)
    if n.bal == 0
      n.bal = -1
    elsif n.bal > 0 || n.left.nil?  # was right heavy
      n.bal =  0
    else  # was left heavy
      case n.left.not_nil!.bal
      when -1
        rotate_right(n)
        n.right.not_nil!.bal = 0
        n.bal = 0
      when  0
        rotate_right(n)
        n.right.not_nil!.bal = -1
        n.bal = +1
      when +1
        b = n.left.not_nil!.right.not_nil!.bal
        rotate_left(n.left.not_nil!)
        rotate_right(n)
        n.left.not_nil!.bal  = b > 0 ? -1 : 0
        n.right.not_nil!.bal = b < 0 ? +1 : 0
        n.bal = 0
      end
    end
  end

  def rotate_left(n)
    # #n=(p0 d1 #m=(p2 d3 p4)) => #n=(#m=(p0 d1 p2) d3 p4)
    p0, d1, p2, d3, p4 = n.left, n.data, n.right.not_nil!.left, n.right.not_nil!.data, n.right.not_nil!.right
    n.left = n.right
    n.left.not_nil!.left, n.left.not_nil!.data, n.left.not_nil!.right, n.data, n.right = p0, d1, p2, d3, p4
    n
  end

  def rotate_right(n)
    # #n=(#m=(p0 d1 p2) d3 p4) => #n=(p0 d1 #m=(p2 d3 p4))
    p0, d1, p2, d3, p4 = n.left.not_nil!.left, n.left.not_nil!.data, n.left.not_nil!.right, n.data, n.right
    n.right = n.left
    n.left, n.data, n.right.not_nil!.left, n.right.not_nil!.data, n.right.not_nil!.right = p0, d1, p2, d3, p4
  end
end



n, k = read_line.split.map(&.to_u64)
ps = read_line.split.map(&.to_u64)

tree = AVLtree.new

last_unsorted = -1

ret = 1_u64
k.times do |i|
  tree.insert ps[i]
  if i >= 1
    if ps[i - 1] > ps[i]
      last_unsorted = i - 1
    end
  end
end

sorted = 0
if last_unsorted == -1
  sorted += 1
end

k.upto(n - 1) do |i|
  v = ps[i]
  pv = ps[i - k]

  if ps[i - 1] > ps[i]
    last_unsorted = i - 1
  end

  tree.delete pv
  if pv < tree.min && tree.max < v
  else
    if i - last_unsorted >= k
      sorted += 1
    end
    ret += 1
  end

  tree.insert v
end

if sorted >= 2
  p ret - sorted + 1
else
  p ret
end
