require 'minitest/autorun'
require_relative '../lib/fetcher'
require_relative 'mock_http_success'

class FetcherTest < Minitest::Test
  def test_fetch_success
    mock_response = MockHTTPSuccess.new(1.0, '200', 'OK')
    mock_response.mock_body = "<html><a href='#'></a><img src='image.jpg'></html>"

    Net::HTTP.stub :get_response, mock_response do
      url = "https://example.com"
      result = fetch(url)

      assert File.exist?(File.join(SAVE_DIRECTORY, "example.com.html"))

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

  def test_fetch_not_found
    mock_not_found = Net::HTTPNotFound.new(1.0, '404', 'Not Found')
    Net::HTTP.stub :get_response, mock_not_found do
      url = "https://invalid_url.com"

      result = fetch(url)
      assert_nil result
    end
  end
end
