require "set"

map = []
File.foreach("6/input.txt") do |line|
  line.chomp!
  map << line.split("")
end
map_copy = map.map { |row| [*row] }

# First find the guard
guard_position = [0, 0]
map.each.with_index do |row, x|
  row.each.with_index do |point, y|
    if point == "^"
      guard_position[0], guard_position[1] = x, y
    end
  end
end
guard_position_copy = [*guard_position]

direction = :up
while guard_position[0] >=0 && guard_position[1] >=0 && guard_position[0] < map.length && guard_position[1] < map[0].length   do
  map[guard_position[0]][guard_position[1]] = "X"

  # Find next position
  case direction
  when :up
    break unless guard_position[0] - 1 >= 0
    next_spot = map.dig(guard_position[0] - 1, guard_position[1])
    if next_spot == "#"
      direction = :right
    else
      guard_position[0] -= 1
    end
  when :down
    break unless guard_position[0] + 1 < map.length
    next_spot = map.dig(guard_position[0] + 1, guard_position[1])
    if next_spot == "#"
      direction = :left
    else
      guard_position[0] += 1
    end
  when :left
    break unless guard_position[1] - 1 >= 0
    next_spot = map.dig(guard_position[0], guard_position[1] - 1)
    if next_spot == "#"
      direction = :up
    else
      guard_position[1] -= 1
    end
  when :right
    break unless guard_position[1] + 1 < map[0].length
    next_spot = map.dig(guard_position[0], guard_position[1] + 1)
    if next_spot == "#"
      direction = :down
    else
      guard_position[1] += 1
    end 
  end
end

result = 0
map.each do |row|
  row.each do |spot|
    result += 1 if spot == "X"
  end
end

puts "Part One - #{result}"


two_result = 0
map_copy.each.with_index do |row, x|
  row.each.with_index do |point, y|
    current_map = map_copy.map { |row| [*row] }
    current_guard_position = [*guard_position_copy]

    next if [x, y] == current_guard_position
    redo_set = Set.new

    # Add new obstacle
    current_map[x][y] = "#"
    coords_passed = ""
    infinite_loop = false

    direction = :up
    while current_guard_position[0] >=0 && current_guard_position[1] >=0 && current_guard_position[0] < current_map.length && current_guard_position[1] < current_map[0].length && !infinite_loop  do
      current_map[current_guard_position[0]][current_guard_position[1]] = "X"
      coords_passed += "#{current_guard_position[0]},#{current_guard_position[1]}"

      # Find next position
      case direction
      when :up
        break unless current_guard_position[0] - 1 >= 0
        next_spot = current_map.dig(current_guard_position[0] - 1, current_guard_position[1])
        if next_spot == "#"
          if coords_passed.count(",") > 1
            if redo_set.member?(coords_passed)
              infinite_loop = true
            else
              redo_set.add(coords_passed)
              coords_passed = ""
            end
          end

          direction = :right
        else
          current_guard_position[0] -= 1
        end
      when :down
        break unless current_guard_position[0] + 1 < map.length
        next_spot = current_map.dig(current_guard_position[0] + 1, current_guard_position[1])
        if next_spot == "#"
          if coords_passed.count(",") > 1
            if redo_set.member?(coords_passed)
              infinite_loop = true
            else
              redo_set.add(coords_passed)
              coords_passed = ""
            end
          end

          direction = :left
        else
          current_guard_position[0] += 1
        end
      when :left
        break unless current_guard_position[1] - 1 >= 0
        next_spot = current_map.dig(current_guard_position[0], current_guard_position[1] - 1)
        if next_spot == "#"
          if coords_passed.count(",") > 1
            if redo_set.member?(coords_passed)
              infinite_loop = true
            else
              redo_set.add(coords_passed)
              coords_passed = ""
            end
          end

          direction = :up
        else
          current_guard_position[1] -= 1
        end
      when :right
        break unless current_guard_position[1] + 1 < map[0].length
        next_spot = current_map.dig(current_guard_position[0], current_guard_position[1] + 1)
        if next_spot == "#"
          if coords_passed.count(",") > 1
            if redo_set.member?(coords_passed)
              infinite_loop = true
            else
              redo_set.add(coords_passed)
              coords_passed = ""
            end
          end

          direction = :down
        else
          current_guard_position[1] += 1
        end
      end
    end

    two_result += 1if infinite_loop
  end
end

puts "Part Two - #{two_result}"
