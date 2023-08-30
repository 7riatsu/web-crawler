require 'minitest/autorun'
require_relative '../lib/page'
require_relative 'mock_http_success'

class PageTest < Minitest::Test
  def setup
    @uri = URI.parse('http://example.com')
    @body = '<html><head></head><body><a href="#">Link</a><link rel="stylesheet" href="style.css"/><script src="script.js"></script><img src="image.jpg"/></body></html>'
    @page = Page.new(@uri, @body)
  end

  def test_initialization
    assert_equal @uri, @page.uri
    assert_instance_of Nokogiri::HTML::Document, @page.body
  end

  def test_save
    Dir.mkdir(Page::SAVE_DIRECTORY) unless Dir.exist?(Page::SAVE_DIRECTORY)

    filename = "#{Page::SAVE_DIRECTORY}/example.com.html"
    File.delete(filename) if File.exist?(filename)

    @page.save
    assert File.exist?(filename)
  end

  def test_extract_assets
    @page.extract_assets

    assert_equal 3, @page.assets.size

    asset_types = @page.assets.map { |asset| URI.parse(asset.url).path.split('.').last }
    assert_includes asset_types, 'css'
    assert_includes asset_types, 'js'
    assert_includes asset_types, 'jpg'
  end
end
