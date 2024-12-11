require "set"

city = []
city_copy = []
antennae = {antinodes: Set.new}
antennae_copy = {antinodes: Set.new}
File.foreach("8/input.txt").with_index do |line, x|
  line.chomp!

  row = line.split("")

  # Map antennae
  row.each.with_index do |item, y|
    if item != "."
      if antennae.has_key?(item)
        antennae[item] << [x, y]
        antennae_copy[item] << [x, y]
      else
        antennae[item] = [[x, y]]
        antennae_copy[item] = [[x, y]]
      end
    end
  end

  city << row
  city_copy << row
end

def mark_antinode!(top_x, top_y, bottom_x, bottom_y, city, antennae)
  x_distance = (top_x - bottom_x).abs
  y_distance = (top_y - bottom_y).abs
  top_on_right = top_y > bottom_y

  top_antinode_coord = [
    top_x - x_distance,
    top_y + (top_on_right ? y_distance : -y_distance)
  ]
  bottom_antinode_coord = [
    bottom_x + x_distance,
    bottom_y - (top_on_right ? y_distance : -y_distance)
  ]

  if top_antinode_coord[0] >= 0 && top_antinode_coord[0] < city.length && top_antinode_coord[1] >= 0 && top_antinode_coord[1] < city[0].length
    city[top_antinode_coord[0]][top_antinode_coord[1]] = "#"
    antennae[:antinodes].add(top_antinode_coord)
  end

  if bottom_antinode_coord[0] >= 0 && bottom_antinode_coord[0] < city.length && bottom_antinode_coord[1] >= 0 && bottom_antinode_coord[1] < city[0].length
    city[bottom_antinode_coord[0]][bottom_antinode_coord[1]] = "#"
    antennae[:antinodes].add(bottom_antinode_coord)
  end
end

antennae.each do |antenna, coords|
  coords.each.with_index do |coord, idx|
    top_coord = coord
    (idx + 1...coords.length).each do |next_coord_idx|
      bottom_coord = coords[next_coord_idx]
      mark_antinode!(top_coord[0], top_coord[1], bottom_coord[0], bottom_coord[1], city, antennae)
    end
  end
end

puts "Part One - #{antennae[:antinodes].count}"

def mark_inf_antinodes!(top_x, top_y, bottom_x, bottom_y, city, antennae)
  x_distance = (top_x - bottom_x).abs
  y_distance = (top_y - bottom_y).abs
  top_on_right = top_y > bottom_y

  top_distance = [-x_distance, (top_on_right ? y_distance : -y_distance)]
  bottom_distance = [x_distance, (top_on_right ? -y_distance : y_distance)]

  top_antinode_coord = [
    top_x + top_distance[0],
    top_y + top_distance[1]
  ]
  bottom_antinode_coord = [
    bottom_x + bottom_distance[0],
    bottom_y + bottom_distance[1]
  ]

  while top_antinode_coord[0] >= 0 && top_antinode_coord[0] < city.length && top_antinode_coord[1] >= 0 && top_antinode_coord[1] < city[0].length do
    city[top_antinode_coord[0]][top_antinode_coord[1]] = "#"
    antennae[:antinodes].add(top_antinode_coord)
    top_antinode_coord = [
      top_antinode_coord[0] + top_distance[0],
      top_antinode_coord[1] + top_distance[1]
    ]
  end

  while bottom_antinode_coord[0] >= 0 && bottom_antinode_coord[0] < city.length && bottom_antinode_coord[1] >= 0 && bottom_antinode_coord[1] < city[0].length do
    city[bottom_antinode_coord[0]][bottom_antinode_coord[1]] = "#"
    antennae[:antinodes].add(bottom_antinode_coord)
    bottom_antinode_coord = [
      bottom_antinode_coord[0] + bottom_distance[0],
      bottom_antinode_coord[1] + bottom_distance[1]
    ]
  end
end

antennae_copy.each do |antenna, coords|
  coords.each.with_index do |coord, idx|
    top_coord = coord
    (idx + 1...coords.length).each do |next_coord_idx|
      bottom_coord = coords[next_coord_idx]
      mark_inf_antinodes!(top_coord[0], top_coord[1], bottom_coord[0], bottom_coord[1], city_copy, antennae_copy)
    end
  end
end

result = Set.new
antennae_copy[:antinodes].each do |ant|
  result.add(ant)
end

antennae_copy.except(:antinodes).select { |_, coords| coords.count > 1 }.each do |_, coords|
  coords.each do |coord|
    result.add(coord)
  end
end

puts "Part Two - #{result.count}"