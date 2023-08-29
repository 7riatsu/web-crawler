#!/usr/bin/env ruby

require_relative '../lib/fetcher'

ARGV.each do |url|
  result = fetch(url)

  if result
    puts "site: #{result[:site]}"
    puts "num_links: #{result[:num_links]}"
    puts "images: #{result[:images]}"
    puts "last_fetched_at: #{result[:last_fetched_at]}"
  else
    puts "Error fetching #{url}"
  end
end
