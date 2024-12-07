number_map = {}
updates = []
mark_updates = false
File.foreach("5/input.txt") do |line|
  line.chomp!

  if line.empty?
    mark_updates = true
    next
  end

  if mark_updates
    updates << line.split(",").map(&:to_i)
  else
    left, right = line.split("|").map(&:to_i)
  
    if number_map.has_key?(left)
      number_map[left][:before] << right
    else
      number_map[left] = {
        before: [right],
        after: []
      }
    end
  
    if number_map.has_key?(right)
      number_map[right][:after] << left
    else
      number_map[right] = {
        before: [],
        after: [left]
      }
    end
  end
end

result = 0
updates.each do |update|
  correct = true
  (0...update.length).each do |idx|
    break unless correct

    current_num = update[idx]
    next unless number_map.has_key?(current_num)

    (idx + 1...update.length).each do |ahead_idx|
      next_num = update[ahead_idx]
      
      if number_map[current_num][:after].include?(next_num)
        correct = false
        break
      end
    end
  end

  result += update[update.length / 2] if correct
end

puts "Part One - #{result}"

two_result = 0
incorrect_updates = []
updates.each do |update|
  correct = true
  (0...update.length).each do |idx|
    break unless correct

    current_num = update[idx]
    next unless number_map.has_key?(current_num)

    (idx + 1...update.length).each do |ahead_idx|
      next_num = update[ahead_idx]
      
      if number_map[current_num][:after].include?(next_num)
        correct = false
        incorrect_updates << update
        break
      end
    end
  end
end

incorrect_updates.each do |update|
  fixed = false
  until fixed do
    changed = false
    (0...update.length).each do |idx|
      break if changed
      current_num = update[idx]
      next unless number_map.has_key?(current_num)

      (idx + 1...update.length).each do |ahead_idx|
        next_num = update[ahead_idx]

        if number_map[current_num][:after].include?(next_num)
          update[idx], update[ahead_idx] = update[ahead_idx], update[idx]
          changed = true
          break
        end
      end
    end
    
    fixed = !changed
  end

  two_result += update[update.length / 2]
end

puts "Part Two - #{two_result}"