require 'net/http'

class MockHTTPSuccess < Net::HTTPSuccess
  attr_accessor :mock_body

  def initialize(version, code, message)
    super(version, code, message)
    @mock_body = ''
  end

  def body
    @mock_body
  end
end
