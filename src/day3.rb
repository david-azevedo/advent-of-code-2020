lines = File.readlines('../data/day3.txt').map {|l| l.strip().split('')}

verticalSize = lines.length
horizontalSize = lines[0].length
slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
result = 1

slopes.each do |slope|
  
  pos_h = 0
  pos_v = 0
  n_trees = 0
  slope_h = slope[0]
  slope_v = slope[1]

  lines.each do |line|
    break if pos_v >= verticalSize
    n_trees += 1 if lines[pos_v][pos_h % horizontalSize] == '#'
  
    pos_h += slope_h
    pos_v += slope_v
  end

  result *= n_trees
end


puts result