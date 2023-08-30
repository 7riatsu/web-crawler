require 'minitest/autorun'
require_relative '../lib/page_metadata'

class PageMetadataTest < Minitest::Test
  def setup
    @metadata = PageMetadata.new(
      site: 'example.com',
      num_links: 10,
      num_images: 5,
      last_fetched_at: Time.now
    )
  end

  def test_initialization
    assert_equal 'example.com', @metadata.site
    assert_equal 10, @metadata.num_links
    assert_equal 5, @metadata.num_images
    assert_instance_of Time, @metadata.last_fetched_at
  end
end
