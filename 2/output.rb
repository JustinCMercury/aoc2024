reports = []
File.foreach("2/input.txt") { |line| reports << line.split(" ").map(&:to_i) }

def is_report_safe(report)
  return false if report.empty?
  return false if report[0] == report[1]

  safe = true
  increasing = report[0] < report[1]
  previous_level = report[0]

  report[1..].each do |current_level|
    safe = increasing ? previous_level < current_level : previous_level > current_level
    break unless safe

    diff = (previous_level - current_level).abs
    safe = diff.between?(1,3)
    break unless safe

    previous_level = current_level
  end

  return safe
end


safe_report_count = 0
reports.each do |report|
  safe_report_count += 1 if is_report_safe(report)
end

puts "Part One - #{safe_report_count}"

safe_report_count_with_pd = 0
reports.each do |report|
  if is_report_safe(report)
    safe_report_count_with_pd += 1
  else
    report.each.with_index do |_, idx|
      report_copy = [*report]
      report_copy.delete_at(idx)

      if is_report_safe(report_copy)
        safe_report_count_with_pd += 1
        break
      end
    end
  end
end

puts "Part Two - #{safe_report_count_with_pd}"
