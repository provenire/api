class PageImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "sources/#{model.source.uuid}/pages/#{model.number - 1}"
  end

  version :large do
    def full_filename(for_file)
      'large.jpg'
    end
  end

  version :normal do
    def full_filename(for_file)
      'normal.jpg'
    end
  end

  version :thumbnail do
    def full_filename(for_file)
      'thumbnail.jpg'
    end
  end
end
