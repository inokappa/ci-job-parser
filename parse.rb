#!/usr/bin/env ruby

require 'json'
require 'open-uri'

#html = open('http://172.16.80.12:8080/job/serverspec/lastBuild/api/json').read
html = open('http://172.16.80.12:8080/job/serverspec/lastSuccessfulBuild/api/json').read
json = JSON.parser.new(html)
#
hash =  json.parse()
parsed = hash['result']
#
if parsed == "FAILURE"
  puts "FAILURE"
  exit 1
else
  puts "SUCCESS"
  exit 0
end
