def is_integer?(s)
  s.to_i.to_s == s
end

result = 0
File.foreach("3/input.txt") do |line|
  left = 0
  right = left + 3

  while left < line.length do
    if line[left..right] == "mul("
      # Look for closing parenthesis
      i = right + 1
      found_close = false
      while !found_close && i - right <= 8 do
        found_close = line[i] === ")"
        break if found_close
        i += 1
      end

      first_num, second_num = line[right + 1...i].split(",")
      if found_close && is_integer?(first_num) && is_integer?(second_num)
        num1 = first_num.to_i
        num2 = second_num.to_i
        result += num1 * num2

        left = i + 1
        right = left + 3
      else
        left += 1
        right += 1
      end
    else
      left += 1
      right += 1
    end
  end
end

puts "Part One - #{result}"

two_result = 0
doing = true
File.foreach("3/input.txt") do |line|
  left = 0
  right = left + 3

  do_left = left
  do_right = left + 3

  dont_left = left
  dont_right = left + 6

  while left < line.length do
    if line[left..right] == "mul("
      i = right + 1
      found_close = false
      while !found_close && i - right <= 8 do
        found_close = line[i] === ")"
        break if found_close
        i += 1
      end

      first_num, second_num = line[right + 1...i].split(",")
      if found_close && is_integer?(first_num) && is_integer?(second_num)
        num1 = first_num.to_i
        num2 = second_num.to_i
        if doing
          two_result += num1 * num2
        end

        left = i + 1
        right = left + 3
        do_left = left
        do_right = left + 3
        dont_left = left
        dont_right = left + 6
      else
        left += 1
        right += 1
        do_left += 1
        do_right += 1
        dont_left += 1
        dont_right += 1
      end
    elsif line[do_left..do_right] == "do()"
      doing = true
      left += 1
      right += 1
      do_left += 1
      do_right += 1
      dont_left += 1
      dont_right += 1
    elsif line[dont_left..dont_right] == "don't()"
      doing = false
      left += 1
      right += 1
      do_left += 1
      do_right += 1
      dont_left += 1
      dont_right += 1
    else
      left += 1
      right += 1
      do_left += 1
      do_right += 1
      dont_left += 1
      dont_right += 1
    end
  end
end

puts "Part Two - #{two_result}"
