# equations = {
#   [target: Integer] => {
#     numbers: Array[Integer]
#     times_seen: Integer
#   }
# }
equations = {}

File.foreach("7/input.txt") do |line|
  line.chomp!
  target, numbers = line.split(": ")

  target = target.to_i
  numbers = numbers.split(" ").map(&:to_i)

  if equations.has_key?(target)
    equations[target][:times_seen] += 1
  else
    equations[target] = {
      numbers: numbers,
      times_seen: 1
    }
  end
end

def found_result?(target, current_num, index, numbers)
  if index >= numbers.length
    return target == current_num
  end

  side_one = found_result?(target, current_num + numbers[index].to_i, index + 1, numbers)
  side_two = found_result?(target, current_num * (numbers[index] || 1), index + 1, numbers)

  side_one || side_two
end

result = 0
equations.each do |target, data|
  numbers = data[:numbers]
  result += target * data[:times_seen] if found_result?(target, numbers[0], 1, numbers)
end

puts "Part One - #{result}"

def found_result_with_concat?(target, current_num, index, numbers)
  if index >= numbers.length
    return target == current_num
  end

  side_one = found_result_with_concat?(target, current_num + numbers[index].to_i, index + 1, numbers)
  side_two = found_result_with_concat?(target, current_num * (numbers[index] || 1), index + 1, numbers)
  side_three = found_result_with_concat?(
    target,
    current_num * 10 ** (numbers[index] ? numbers[index].to_s.length : 0) + (numbers[index] || 0),
    index + 1,
    numbers
  )

  side_one || side_two || side_three
end

two_result = 0
equations.each do |target, data|
  numbers = data[:numbers]
  two_result += target * data[:times_seen] if found_result_with_concat?(target, numbers[0], 1, numbers)
end

puts "Part Two - #{two_result}"
