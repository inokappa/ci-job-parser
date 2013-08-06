#!/usr/bin/env ruby

require 'json'
require 'open-uri'

html = open('http://xxx.xxx.xxx.xxx:8080/api/json').read
json = JSON.parser.new(html)
hash =  json.parse()
parsed = hash['jobs']
#
parsed.each do |jobs|
  puts jobs['name'] + ' / ' + jobs['color']
  job_name = jobs['name']
  job_url = "http://xxx.xxx.xxx.xxx:8080/job/#{job_name}/lastBuild/api/json"
  begin
    job_html = open("#{job_url}").read
    rescue => exception
      case exception
      when OpenURI::HTTPError
        puts "does not exist lastbuild"
      end
    else
      job_json = JSON.parser.new(job_html)
      job_parsed = job_json.parse()
      result = job_parsed["result"]
      if result == "FAILURE"
          puts "Problem"
        else
          puts "Success."
      end
    ensure
      puts "end" 
    end
end
