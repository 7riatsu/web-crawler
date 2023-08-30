module Utilities
  def ensure_directory_exists(directory)
    Dir.mkdir(directory) unless Dir.exist?(directory)
  end
end
