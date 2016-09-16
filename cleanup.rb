require 'twitter'
require "json"

# To make this script work
# First download all the twitter data-> rename file to tweets and place in this directory
# Then run ruby cleanup.rb

USERNAME = 'SimpleRishi'

client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "yCJ9ntcsw5PtXYBEdGr5axQrk"
    config.consumer_secret     = "GkvxI8KGWySguJsQANXoZaYERdp7BwuVuSoFhSXOxeUGEh0EOA"
    config.access_token        = "775703165245071365-rEaz4kUp2trAGK6dQFyoqet0bb0zcAL"
    config.access_token_secret = "NfkmJiFLxmx4abkrsbiIczzlVW7EVC5Ww1whwvg3lQ5kQ"
end

Dir.foreach('tweets/data/js/tweets') do |item|

  unless (item == '.') or (item == '..') or (item == '.DS_Store') 
    #ignore system files and paths
    
    file = File.readlines("tweets/data/js/tweets/#{item}")[1..-1].join()
    data = JSON.parse(file)

    data.each do |tweet|
      removeId = tweet['id']
      begin
        client.destroy_status(removeId)
        puts "destroyed tweet_id: #{removeId}"
      rescue => e
        puts "ooops: #{e} -- t_id: #{removeId}"
      end
    end

  end

end

