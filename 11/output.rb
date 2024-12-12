stones = {}
File.foreach("11/input.txt") do |line|
  line.chomp.split(" ").map(&:to_i).each do |stone|
    if stones[stone]
      stones[stone] += 1
    else
      stones[stone] = 1
    end
  end
end
stones_copy = {**stones}

def split_stone(stone)
  length = Math.log10(stone).to_i + 1
  exp = 10 ** (length / 2)
  [stone / exp, stone % exp]
end

def blink(stones)
  stones.reduce({}) do |res, (stone, count)|
    # Figure out what the next stones are
    if stone.zero?
      if res[1]
        res[1] += count
      else
        res[1] = count
      end
    elsif (Math.log10(stone).to_i + 1).even?
      split_stone(stone).each do |s|
        if res[s]
          res[s] += count
        else
          res[s] = count
        end
      end
    else
      s2024 = stone * 2024
      if res[s2024]
        res[s2024] += count
      else
        res[s2024] = count
      end
    end

    res
  end
end


25.times do
  stones = blink(stones)
end

puts "Part One - #{stones.reduce(0) { |res, (_, count)| res + count }}"

75.times do
  stones_copy = blink(stones_copy)
end

puts "Part Two - #{stones_copy.reduce(0) { |res, (_, count)| res + count }}"