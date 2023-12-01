require 'csv'
total=0

def find_number(row)
  first_num=nil
  last_num=nil
  row.first.split('').each do |char|
   char_num = Integer(char) rescue nil
   first_num = char if (char_num && first_num.nil?)  
  end
  row.first.reverse.split('').each do |char|
    char_num = Integer(char) rescue nil
    last_num = char if (char_num && last_num.nil?)  
  end
  return first_num.concat(last_num).to_i
end

CSV.foreach('/Users/dustinhaefele/other-code/advent_2023/day1/input.csv') do |row|
  total += find_number(row)
end

puts total
