require 'net/http'
require 'nokogiri'
require 'uri'

require_relative 'page'
require_relative 'asset'
require_relative 'page_metadata'

class Fetcher
  def initialize(url)
    @uri = URI.parse(url)
    @page = nil
  end

  def fetch
    response = Net::HTTP.get_response(@uri)
    return nil unless response.is_a?(Net::HTTPSuccess)

    @page = Page.new(@uri, response.body)
    @page.save
    @page.extract_assets

    visited = {}
    @page.assets.each do |asset|
      asset.download(@uri.to_s, visited)
    end

    num_links = @page.body.css('a').size
    num_images = @page.body.css('img').size

    PageMetadata.new(
      site: @uri.host,
      num_links: num_links,
      num_images: num_images,
      last_fetched_at: Time.now
    )
  end
end
