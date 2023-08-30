require 'minitest/autorun'
require_relative '../lib/asset'
require_relative 'mock_http_success'

class AssetTest < Minitest::Test
  def setup
    @url = '/some/path/to/asset.css'
    @path = './some_local_path/asset.css'
    @asset = Asset.new(@url, @path)
    @mock_response = MockHTTPSuccess.new(1.0, '200', 'OK')
    @mock_response.mock_body = 'mock_body_content'
  end

  def test_initialize
    assert_equal @url, @asset.url
    assert_equal @path, @asset.path
  end

  def test_download
    Net::HTTP.stub :get_response, @mock_response do
      visited = {}
      @asset.download('http://localhost', visited)

      assert_equal true, visited[@url]
      assert_equal 'mock_body_content', File.read(@path)
    end

    File.delete(@path)
  end
end
