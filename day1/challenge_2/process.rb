require 'csv'
total=0
POS_INF = 1.0/0.0
NEG_INF = -1.0/0.0 

WORDS_TO_FIND = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
NUMBERS_TO_FIND = ['0','1','2','3','4','5','6','7','8','9']


def find_highest_index(string, sub)
  a = string.enum_for(:scan,/#{sub}/).map { Regexp.last_match.begin(0) }
  a.length ? a.max : nil
end

def find_lowest_index(string, sub)
  a = string.enum_for(:scan,/#{sub}/).map { Regexp.last_match.begin(0) }
  a.length ? a.min : nil
end



def find_number_with_words(row, words_to_find, numbers_to_find)
  first_hash = {'0' => POS_INF, '1' => POS_INF, '2' => POS_INF, '3' => POS_INF, '4' => POS_INF, '5' => POS_INF, '6' => POS_INF, '7' => POS_INF, '8' => POS_INF, '9' => POS_INF}
  last_hash = {'0' => NEG_INF, '1' => NEG_INF, '2' => NEG_INF, '3' => NEG_INF, '4' => NEG_INF, '5' => NEG_INF, '6' => NEG_INF, '7' => NEG_INF, '8' => NEG_INF, '9' => NEG_INF}

  words_to_find.each_with_index do |word, ind|
    string_dex = ind.to_s
    lowest_index = find_lowest_index(row.first, word)
    highest_index = find_highest_index(row.first, word)
    first_hash[string_dex] = lowest_index if (!lowest_index.nil? && first_hash[string_dex].nil?) || (lowest_index && lowest_index < first_hash[string_dex])
    last_hash[string_dex] = highest_index if (!highest_index.nil? && last_hash[string_dex].nil?) || (highest_index && highest_index > last_hash[string_dex])
  end
  numbers_to_find.each_with_index do |num, ind|
    string_dex = ind.to_s
    lowest_index = find_lowest_index(row.first, num)
    highest_index = find_highest_index(row.first, num)
    first_hash[string_dex] = lowest_index if (!lowest_index.nil? && first_hash[string_dex].nil?) || (!lowest_index.nil? && lowest_index < first_hash[string_dex])
    last_hash[string_dex] = highest_index if (!highest_index.nil? && last_hash[string_dex].nil?) || (!highest_index.nil? && highest_index > last_hash[string_dex])
  end
  first_digit=first_hash.min_by{|k,v| v}.first
  last_digit=last_hash.max_by{|k,v| v}.first
  ans = (first_digit + last_digit).to_i
end

CSV.foreach('/Users/dustinhaefele/other-code/advent_2023/day1/input.csv') do |row|
  total += find_number_with_words(row, WORDS_TO_FIND, NUMBERS_TO_FIND)
end

puts total
