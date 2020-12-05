require 'open-uri'

session_cookie = ENV['AOC_SESSION_COOKIE']

day = ARGV[0]? ARGV[0] : "1"
year = ARGV[1]? ARGV[1] : "2020"

data_url = "https://adventofcode.com/#{year}/day/#{day}/input"
data = open(data_url, { "Cookie" => "session=#{session_cookie}" }).read

File.write("data/day#{day}.txt",data)
