class PageMetadata
  attr_reader :site, :num_links, :num_images, :last_fetched_at

  def initialize(site:, num_links:, num_images:, last_fetched_at:)
    @site = site
    @num_links = num_links
    @num_images = num_images
    @last_fetched_at = last_fetched_at
  end
end
