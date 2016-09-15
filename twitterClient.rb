#!/usr/bin/ruby

require 'twitter'
require_relative 'wordTree.rb'

class TwitterClient
  @client
  @ai

def initialize(ai)
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "yCJ9ntcsw5PtXYBEdGr5axQrk"
    config.consumer_secret     = "GkvxI8KGWySguJsQANXoZaYERdp7BwuVuSoFhSXOxeUGEh0EOA"
    config.access_token        = "775703165245071365-rEaz4kUp2trAGK6dQFyoqet0bb0zcAL"
    config.access_token_secret = "NfkmJiFLxmx4abkrsbiIczzlVW7EVC5Ww1whwvg3lQ5kQ"
  end
  @ai=ai
end

  def showTweets tweets
    tweets.each do |tweet|
      puts tweet
      puts tweet.text
      puts tweet.source
    end
  end

  def answerTweet tweet
    return @ai.answer(tweet.text)
  end

  def respondToTweets
    tweets = @client.user_timeline
    response = ""
    tweets.each do |tweet|
      if tweet.text.start_with?("01 ") then break end
      if tweet.text.start_with?("learn ")then
        learnTweet(tweet)
      else
        response.concat(respondToTweet(tweet))
      end
    end
    return response
  end

  def learnTweet tweet
    info = tweet.text.split(" : ")
    @ai.learn(info[1],info[2])
  end

  def respondToTweet(tweet)
    return "".concat(answerTweet tweet).concat("\n")
  end
  
  def getClient
    return @client
  end

  def post
    result = respondToTweets
    if result != "\n" && result != ""then
      result.prepend("01 ")
      puts "respond to twitter:a#{result}a"
      @client.update(result)
    end 
  end
end

