# frozen_string_literal: true

require 'open-uri'

day = ARGV[0] || '1'
year = ARGV[1] || '2020'

data_url = "https://adventofcode.com/#{year}/day/#{day}/input"
data = open(data_url, 'Cookie' => "session=#{ENV['AOC_SESSION_COOKIE']}").read

File.write("#{__dir__}/day#{day}.txt", data)

puts 'Done!'
