matrix = 20.times.map do
  gets.split.map(&:to_i)
end
vs = []
20.times do |x|
  17.times do |y|
    vs << matrix[x][y] * matrix[x][y + 1] * matrix[x][y + 2] * matrix[x][y + 3]
    vs << matrix[y][x] * matrix[y + 1][x] * matrix[y + 2][x] * matrix[y + 3][x]
  end
end
17.times do |x|
  17.times do |y|
    vs << matrix[x][y] * matrix[x + 1][y + 1] * matrix[x + 2][y + 2] * matrix[x + 3][y + 3]
    vs << matrix[x + 3][y] * matrix[x + 2][y + 1] * matrix[x + 1][y + 2] * matrix[x][y + 3]
  end
end
p vs.max