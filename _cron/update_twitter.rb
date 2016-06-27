#!/usr/bin/env ruby
require 'rubygems'
require 'oauth'

# Edit config to suit your needs
config = {
  :consumer_key => 'p8TPfx55luGDmTl4Eusz27EcI',
  :consumer_secret => 'P8xD3m8Qon9zTvO6KLikLRaxif0EcDoubNNNaykOayVh8JCyKl',
  :oauth_token => '34993003-1lXXtZduuuFmezBhucv5C1n4XftBTM5kJfpc8xCci',
  :oauth_token_secret => 'srAOMty5LKumpJu7DlPSXWvfYKrblASTps43BxTJ4Bbcv',
  :output_path_en => '/srv/babaei.net/wen/twitter_timeline.json',
  :output_path_fa => '/srv/babaei.net/wfa/twitter_timeline.json'
}

# Create OAuth context
oauth = OAuth::Consumer.new(
  config[:consumer_key],
  config[:consumer_secret],
  { :site => "http://twitter.com", :scheme => :header }
)
access_token = OAuth::AccessToken.from_hash(
  oauth,
  { :oauth_token => config[:oauth_token], :oauth_token_secret => config[:oauth_token_secret] }
)

# Get timeline
url = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=NuLL3rr0r&trim_user=true&count=22&include_entities=1&exclude_replies=1'
response = access_token.request(:get, url)

# Write response into output file with JSONP wrapper
File.open(config[:output_path_en], 'w') { |file|
  file.write('processTweeter(')
  file.write(response.body)
  file.write(');')
}
File.open(config[:output_path_fa], 'w') { |file|
  file.write('processTweeter(')
  file.write(response.body)
  file.write(');')
}

