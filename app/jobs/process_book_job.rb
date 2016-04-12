class ProcessBookJob < ActiveJob::Base
  queue_as :default

  def perform(source)
    # Get cover
    cover_url = "http://books.google.com/books/content?printsec=frontcover&img=1&zoom=6&id=#{source.attribution}"
    source.update(remote_image_url: cover_url) unless source.attribution.empty?
  end
end
