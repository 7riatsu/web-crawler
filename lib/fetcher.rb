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

  assets = download_assets(html_body, uri.host)
  assets.each do |original, local|
    html_body.to_s.gsub!(original, local)
  end

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

def download_assets(html_body, host, visited = {})
  assets = {}

  # Selector to get only CSS, JS, IMG assets
  asset_nodes = html_body.css('link[rel="stylesheet"], script[src], img[src]')

  asset_nodes.each do |node|
    url = node['href'] || node['src']
    next unless url

    host = "http://#{host}" unless host =~ /^https?:/
    uri = URI.join(host, url)
    next if visited[uri.to_s]  # Skip if already visited to avoid infinite loop

    visited[uri.to_s] = true

    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      filename = File.basename(uri.path).empty? ? 'index.html' : File.basename(uri.path)
      local_path = File.join(SAVE_DIRECTORY, filename)

      File.write(local_path, response.body)
      assets[url] = local_path

      if uri.path.end_with?('.css') || uri.path.end_with?('.js')
        download_assets(Nokogiri::HTML(response.body), uri.to_s, visited)
      end
    end
  end

  assets
end
