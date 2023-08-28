require 'net/http'
require 'nokogiri'
require 'uri'

def fetch(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  return nil unless response.is_a?(Net::HTTPSuccess)

  # TODO:
  # Save to disk

  # Fetch metadata

  # {
  #   site:,
  #   num_links:,
  #   images:,
  #   last_fetched_at
  # }
end