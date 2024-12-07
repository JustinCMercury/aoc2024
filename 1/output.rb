require "set"

# Convert input data
location_ids_1 = []
location_ids_2 = []

File.foreach("1/input.txt") do |line|
  id1, id2 = line.split(" ")
  location_ids_1 << id1.to_i
  location_ids_2 << id2.to_i
end

# Sort IDs
location_ids_1.sort!
location_ids_2.sort!

# Add up differences
result = 0
location_ids_1.each.with_index do |id1, idx|
  id2 = location_ids_2[idx]
  result += (id1 - id2).abs
end

puts "Part One - #{result}"

# Tally up second list and search for the unique ids
ids1_set = location_ids_1.to_set
ids2_tally = location_ids_2.tally

extra_result = 0
ids1_set.each do |id1|
  if ids2_tally.has_key? id1
    extra_result += id1 * ids2_tally[id1]
  end
end

puts "Part Two - #{extra_result}"