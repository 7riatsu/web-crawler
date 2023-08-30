require 'minitest/autorun'
require_relative '../lib/utilities'

class UtilitiesTest < Minitest::Test
  include Utilities

  def setup
    @directory = "./test_directory"
    Dir.rmdir(@directory) if Dir.exist?(@directory)
  end

  def test_ensure_directory_exists_creates_directory
    refute Dir.exist?(@directory), "Directory should not exist before test"

    ensure_directory_exists(@directory)

    assert Dir.exist?(@directory), "Directory should exist after method call"
  end

  def teardown
    Dir.rmdir(@directory) if Dir.exist?(@directory)
  end
end
