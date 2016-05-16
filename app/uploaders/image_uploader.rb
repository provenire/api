class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'jpg'
  process tags: ['provenire', 'page']

  version :large do
    process eager: true
    cloudinary_transformation transformation: 'page_large'
  end

  version :normal do
    process eager: true
    cloudinary_transformation transformation: 'page_normal'
  end

  version :thumbnail do
    process eager: true
    cloudinary_transformation transformation: 'page_thumbnail'
  end

  version :index do
    process eager: true
    cloudinary_transformation transformation: 'index'
  end

  version :show do
    process eager: true
    cloudinary_transformation transformation: 'show'
  end

  version :show_half do
    process eager: true
    cloudinary_transformation transformation: 'show_half'
  end
end
