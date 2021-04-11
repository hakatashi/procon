class Array(T)
  private struct EachConsPair(T)
    include Enumerable({T, T})
    def initialize(@array : Array(T))
    end
    def each
      @array.each_cons_pair {|a, b| yield ({a, b})}
    end
  end
  def each_cons_pair
    EachConsPair(T).new(self)
  end
end


n = read_line.to_i64
s = read_line.chars
ais = read_line.split.map(&.to_i64)

k = ais.each_cons_pair.map {|a, b| (a - b).abs}.min
p k
k.times do |i|
  puts ais.map {|a| (a + i) // k}.join(' ')
end
