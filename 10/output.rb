require "set"

# Locate all the 0 coordinates
# Do a Dfs to each 9 and return 1 for each 9
# Guard clause is: when there are no next consecutive numbers, return 0.
# If it's a 9, return 1 as long as we haven't visited it before

map = []
zero_coords = []

File.foreach("10/input.txt").with_index do |line, x|
  row = line.chomp.split("").map(&:to_i)

  row.each.with_index do |item, y|
    zero_coords << [x, y] if item.zero?
  end

  map << row
end

def count_routes(num, x, y, map, seen, nines_visited)
  return 0 if x < 0 || y < 0
  return 0 if x >= map.length || y >= map.first.length

  if num == 9
    if nines_visited.include?([x, y])
      return 0
    else
      nines_visited.add([x, y])
      return 1
    end
  end

  above_coords = [x - 1, y]
  below_coords = [x + 1, y]
  left_coords = [x, y - 1]
  right_coords = [x, y + 1]

  next_num = num + 1

  # Check above
  above = 0
  if above_coords[0] >= 0 && above_coords[0] < map.length && !seen.include?(above_coords)
    if map[above_coords[0]][above_coords[1]] == next_num
      above += count_routes(
        next_num,
        above_coords[0],
        above_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]]),
        nines_visited
      )
    end
  end

  # Check below
  below = 0
  if below_coords[0] >= 0 && below_coords[0] < map.length && !seen.include?(below_coords)
    if map[below_coords[0]][below_coords[1]] == next_num
      below += count_routes(
        next_num,
        below_coords[0],
        below_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]]),
        nines_visited
      )
    end
  end

  # Check left
  left = 0
  if left_coords[1] >= 0 && left_coords[1] < map.first.length && !seen.include?(left_coords)
    if map[left_coords[0]][left_coords[1]] == next_num
      left += count_routes(
        next_num,
        left_coords[0],
        left_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]]),
        nines_visited
      )
    end
  end

  # Check right
  right = 0
  if right_coords[1] >= 0 && right_coords[1] < map.first.length && !seen.include?(right_coords)
    if map[right_coords[0]][right_coords[1]] == next_num
      right += count_routes(
        next_num,
        right_coords[0],
        right_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]]),
        nines_visited
      )
    end
  end

  nines_visited.count
end


result = 0
zero_coords.each do |coord|
  result += count_routes(0, coord[0], coord[1], map, [], Set.new)
end

puts "Part One - #{result}"

def count_routes_without_saving(num, x, y, map, seen)
  return 0 if x < 0 || y < 0
  return 0 if x >= map.length || y >= map.first.length

  return 1 if num == 9

  above_coords = [x - 1, y]
  below_coords = [x + 1, y]
  left_coords = [x, y - 1]
  right_coords = [x, y + 1]

  next_num = num + 1

  # Check above
  above = 0
  if above_coords[0] >= 0 && above_coords[0] < map.length && !seen.include?(above_coords)
    if map[above_coords[0]][above_coords[1]] == next_num
      above += count_routes_without_saving(
        next_num,
        above_coords[0],
        above_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]])
      )
    end
  end

  # Check below
  below = 0
  if below_coords[0] >= 0 && below_coords[0] < map.length && !seen.include?(below_coords)
    if map[below_coords[0]][below_coords[1]] == next_num
      below += count_routes_without_saving(
        next_num,
        below_coords[0],
        below_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]])
      )
    end
  end

  # Check left
  left = 0
  if left_coords[1] >= 0 && left_coords[1] < map.first.length && !seen.include?(left_coords)
    if map[left_coords[0]][left_coords[1]] == next_num
      left += count_routes_without_saving(
        next_num,
        left_coords[0],
        left_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]])
      )
    end
  end

  # Check right
  right = 0
  if right_coords[1] >= 0 && right_coords[1] < map.first.length && !seen.include?(right_coords)
    if map[right_coords[0]][right_coords[1]] == next_num
      right += count_routes_without_saving(
        next_num,
        right_coords[0],
        right_coords[1],
        map,
        seen.map{|c| [*c]}.concat([[x, y]])
      )
    end
  end

  above + below + left + right
end

two_result = 0
zero_coords.each do |coord|
  two_result += count_routes_without_saving(0, coord[0], coord[1], map, [])
end

puts "Part Two - #{two_result}"
