require_relative 'twitterClient.rb'
require_relative 'wordTree.rb'
require_relative 'learn.rb'

# To Teach post: "learn : <words> : <response>"
# To ask, post: <anything>



rishi = WordTree.new # This is considered the AI, it holds all memory 
client = TwitterClient.new(rishi) # This is to talk to Twitter
learn rishi # This teaches the AI, can learn more from twitter

while true
  puts "\n----------------------------------------------------------"
  puts "running rishi"
  client.post
  sleep 5
end
