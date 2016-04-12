class DocumentUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "sources/#{model.uuid}/document"
  end
end
