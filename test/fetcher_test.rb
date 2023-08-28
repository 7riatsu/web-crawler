require 'minitest/autorun'
require_relative '../lib/fetcher'

class FetcherTest < Minitest::Test
  def test_fetch_success
    mock_response = Struct.new(:body).new("<html><a href='#'></a><img src='image.jpg'></html>")
    Net::HTTP.stub :get_response, mock_response do
      url = "https://example.com"
      result = fetch(url)

      assert File.exist?("example.com.html")

      refute_nil result[:last_fetched_at]
      assert_equal 1, result[:num_links]
      assert_equal 1, result[:images]
    end
  end

  def test_fetch_failure
    Net::HTTP.stub :get_response, ->(_) { raise StandardError.new("Error fetching URL") } do
      url = "https://invalid_url.com"

      assert_raises do
        fetch(url)
      end
    end
  end
end
