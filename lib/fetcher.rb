require 'net/http'
require 'nokogiri'
require 'uri'

def fetch(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  return nil unless response.is_a?(Net::HTTPSuccess)

  # Save to disk
  host = uri.host
  File.write("#{host}.html", response.body)

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
