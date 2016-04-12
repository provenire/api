class ProcessDocumentJob < ActiveJob::Base
  queue_as :default


  def perform(source)
    # 1. Set class source
    @source = source

    # 2. Capture thumbnails
    @captured = capture
    retry_job(wait: 30.seconds) if @captured.error?

    # 3. Update source document/image
    @source.update(remote_image_url: document_image_url)
    @source.update_columns(document: document_name)

    # 4. Generate source pages
    (1..page_count).each do |page_number|
      page = @source.pages.create(number: page_number)
      page.update_columns(image: 'page.jpg')
    end
  end


  # Document name
  def document_name
    @captured[:results]["document"][0]["name"]
  end

  def document_image_url
    @captured[:results]["document_image"][0]["ssl_url"]
  end

  def page_count
    @captured[:results]["document"][0]["meta"]["page_count"]
  end


  # Capture thumbnails
  def capture
    fields      = { uuid: @source.uuid }
    transloadit = Transloadit.new(key: ENV['TRANSLOADIT_AUTH_KEY'], secret: ENV['TRANSLOADIT_SECRET_KEY'])
    assembly    = transloadit.assembly(template_id: ENV['TRANSLOADIT_DOCUMENT_TEMPLATE'], fields: fields)
    response    = assembly.submit!
    (sleep 1; response.reload!) until response.finished?
    response
  end
end
