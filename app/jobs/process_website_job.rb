class ProcessWebsiteJob < ActiveJob::Base
  queue_as :default


  def perform(source)
    # 1. Set class source
    @source = source

    # 2. Extract website
    @extracted = extract

    # 3. Update attributes
    @source.update(
      name:         name,
      description:  description,
      authors:      authors,
      date_created: date_created,
      attribution:  attribution
    ) if new_website?

    # 4. Capture screenshots
    captured = capture

    # 5. Verify valid screenshot
    begin
      img = captured[:results]["resize_image"][0]["ssl_url"]
    rescue
      return
    end

    # 6. Update source document/image
    @source.update(remote_image_url: captured[:results]["resize_image"][0]["ssl_url"])
    @source.update_columns(document: "#{document_name}.jpg")

    # 7. Generate source page
    page = @source.pages.create(number: 1, text: page_text)
    page.update_columns(image: 'page.jpg')
  end


  # Attributes
  def name
    @extracted.title || ''
  end

  def authors
    @extracted.authors.map{|a| a["name"].titleize }.to_sentence
  end

  def description
    @extracted.description || ''
  end

  def date_created
    @extracted.published && Time.at(@extracted.published/1000) || ''
  end

  def attribution
    "#{@extracted.provider_name} (#{@extracted.provider_display})"
  end

  def page_text
    ActionView::Base.full_sanitizer.sanitize(@extracted.content) || ''
  end

  def document_name
    "#{name.parameterize}_#{Date.current}"
  end

  def new_website?
    @source.name == @source.identifier
  end


  # User Agent
  def user_agent
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36"
  end


  # Extract a URL
  def extract
    Embedly::API.new(user_agent: user_agent).extract(url: @source.identifier).first
  end


  # Capture Screenshots
  def capture
    fields      = { url: @source.identifier, uuid: @source.uuid, document_name: document_name }
    transloadit = Transloadit.new(key: ENV['TRANSLOADIT_AUTH_KEY'], secret: ENV['TRANSLOADIT_SECRET_KEY'])
    assembly    = transloadit.assembly(template_id: ENV['TRANSLOADIT_WEBSITE_TEMPLATE'], fields: fields)
    response    = assembly.submit!
    (sleep 1; response.reload!) until response.finished?
    response
  end
end
