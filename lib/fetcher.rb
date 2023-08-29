require 'net/http'
require 'nokogiri'
require 'uri'

SAVE_DIRECTORY = '/app/saved_pages'.freeze

def fetch(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  return nil unless response.is_a?(Net::HTTPSuccess)

  # Make sure directory exists
  Dir.mkdir(SAVE_DIRECTORY) unless Dir.exist?(SAVE_DIRECTORY)

  # Save to disk
  host = uri.host
  File.write(File.join(SAVE_DIRECTORY, "#{host}.html"), response.body)

  # Fetch metadata
  html_body = Nokogiri::HTML(response.body)
  num_links = html_body.css('a').size
  num_images = html_body.css('img').size
  last_fetched_at = Time.now

  {
    site: host,
    num_links: num_links,
    images: num_images,
    last_fetched_at: last_fetched_at
  }
end
