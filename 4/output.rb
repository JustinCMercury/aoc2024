xmas_grid = []
File.foreach("4/input.txt") do |line|
  xmas_grid << line.split("")
end

result = 0
xmas_grid.each.with_index do |row, x|
  row.each.with_index do |char, y|
    if char == "X"
      # Check forwards
      forwards = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x, y + 1)}#{xmas_grid.dig(x, y + 2)}#{xmas_grid.dig(x, y + 3)}"
      result += 1 if forwards == "XMAS" && y + 3 < row.length
      # Check backwards
      backwards = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x, y - 1)}#{xmas_grid.dig(x, y - 2)}#{xmas_grid.dig(x, y - 3)}"
      result += 1 if backwards == "XMAS" && y - 3 >= 0

      # Check up
      up = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x - 1, y)}#{xmas_grid.dig(x - 2, y)}#{xmas_grid.dig(x - 3, y)}"
      result += 1 if up == "XMAS" && x - 3 >= 0
      # Check down
      down = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x + 1, y)}#{xmas_grid.dig(x + 2, y)}#{xmas_grid.dig(x + 3, y)}"
      result += 1 if down == "XMAS" && x + 3 < xmas_grid.length

      # Check upforward
      upforward = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x - 1, y + 1)}#{xmas_grid.dig(x - 2, y + 2)}#{xmas_grid.dig(x - 3, y + 3)}"
      result += 1 if upforward == "XMAS" && x - 3 >= 0 && y + 3 < row.length
      # Check upback
      upback = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x - 1, y - 1)}#{xmas_grid.dig(x - 2, y - 2)}#{xmas_grid.dig(x - 3, y - 3)}"
      result += 1 if upback == "XMAS" && x - 3 >= 0 && y - 3 >= 0

      # Check downforward
      downforward = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x + 1, y + 1)}#{xmas_grid.dig(x + 2, y + 2)}#{xmas_grid.dig(x + 3, y + 3)}"
      result += 1 if downforward == "XMAS" && x + 3 < xmas_grid.length && y + 3 < row.length
      # Check downback
      downback = "#{xmas_grid.dig(x, y)}#{xmas_grid.dig(x + 1, y - 1)}#{xmas_grid.dig(x + 2, y - 2)}#{xmas_grid.dig(x + 3, y - 3)}"
      result += 1 if downback == "XMAS" && x + 3 < xmas_grid.length && y - 3 >= 0
    end
  end
end

puts "Part One - #{result}"

two_result = 0
xmas_grid.each.with_index do |row, x|
  row.each.with_index do |char, y|
    if char == "A"
      # MM on top SS on bottom
      top_bottom = "#{xmas_grid.dig(x - 1, y - 1)}#{xmas_grid.dig(x - 1, y + 1)}#{xmas_grid.dig(x + 1, y - 1)}#{xmas_grid.dig(x + 1, y + 1)}"
      two_result += 1 if top_bottom == "MMSS" && x - 1 >= 0 && y - 1 >=0 && y + 1 < row.length && x + 1 < xmas_grid.length

      # MM on bottom SS on top
      bottom_top = "#{xmas_grid.dig(x + 1, y - 1)}#{xmas_grid.dig(x + 1, y + 1)}#{xmas_grid.dig(x - 1, y - 1)}#{xmas_grid.dig(x - 1, y + 1)}"
      two_result += 1 if bottom_top == "MMSS" && x - 1 >= 0 && y - 1 >=0 && y + 1 < row.length && x + 1 < xmas_grid.length

      # MM on left SS on right
      left_right = "#{xmas_grid.dig(x - 1, y - 1)}#{xmas_grid.dig(x + 1, y - 1)}#{xmas_grid.dig(x + 1, y + 1)}#{xmas_grid.dig(x - 1, y + 1)}"
      two_result += 1 if left_right == "MMSS" && x - 1 >= 0 && y - 1 >=0 && y + 1 < row.length && x + 1 < xmas_grid.length

      # MM on right SS on left
      left_right = "#{xmas_grid.dig(x + 1, y + 1)}#{xmas_grid.dig(x - 1, y + 1)}#{xmas_grid.dig(x - 1, y - 1)}#{xmas_grid.dig(x + 1, y - 1)}"
      two_result += 1 if left_right == "MMSS" && x - 1 >= 0 && y - 1 >=0 && y + 1 < row.length && x + 1 < xmas_grid.length
    end
  end
end

puts "Part Two - #{two_result}"
