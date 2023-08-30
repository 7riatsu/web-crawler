class Asset
  attr_reader :url, :path

  def initialize(url, path)
    @url = url
    @path = path
  end

  def download(host, visited = {})
    return if visited[@url]

    visited[@url] = true

    uri = URI.join(host, @url)
    response = Net::HTTP.get_response(uri)

    return unless response.is_a?(Net::HTTPSuccess)

    File.write(@path, response.body)
  end
end
