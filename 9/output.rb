disk_map = []
File.foreach("9/input.txt") do |line|
  line.chomp!

  id = 0
  line.each_char.with_index do |num, idx|
    file_block = idx.even?
    count = num.to_i

    if file_block
      count.times { disk_map << id.to_s }
      id += 1
    else
      count.times { disk_map << "." }
    end
  end
end

left = 0
right = disk_map.length - 1
while right >= 0 && disk_map[right] == "." do
  right -= 1
end

while left < right do
  if disk_map[left] == "."
    disk_map[left] = disk_map[right]
    disk_map[right] = "."

    while right >= 0 && disk_map[right] == "." do
      right -= 1
    end
  end
  left += 1
end

result = 0
id = 0
disk_map.each do |bit|
  next if bit == "."
  result += id * bit.to_i
  id += 1
end

puts "Part One - #{result}"

# TODO
# puts "Part Two - #{two_result}"
