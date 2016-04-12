class ProcessPhotoJob < ActiveJob::Base
  queue_as :default

  def perform(source)
    # Set source image
    source.update(remote_image_url: source.document.url)

    # Generate a page
    source.pages.create(number: 1, remote_image_url: source.document.url)
  end
end
