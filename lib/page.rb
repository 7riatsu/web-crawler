require_relative 'asset'
require_relative 'utilities'

SAVE_DIRECTORY = '/app/saved_pages'.freeze

class Page
  include Utilities

  attr_reader :uri, :body, :assets

  def initialize(uri, body)
    @uri = uri
    @body = Nokogiri::HTML(body)
    @assets = []

    ensure_directory_exists(SAVE_DIRECTORY)
  end

  def save
    filename = File.join(SAVE_DIRECTORY, "#{uri.host}.html")
    File.write(filename, body.to_html)
  end

  def extract_assets
    asset_nodes = @body.css('link[rel="stylesheet"], script[src], img[src]')
    asset_nodes.each do |node|
      url = node['href'] || node['src']
      next unless url

      filename = File.basename(URI.parse(url).path)
      path = File.join(SAVE_DIRECTORY, filename)
      asset = Asset.new(url, path)

      @assets << asset
    end
  end
end
