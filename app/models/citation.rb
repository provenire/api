# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  entry_id   :integer
#  entry_type :string
#  number     :integer
#  content    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_citations_on_entry_type_and_entry_id  (entry_type,entry_id)
#  index_citations_on_source_id                (source_id)
#

class Citation < ActiveRecord::Base

  # Associations
  belongs_to :source
  belongs_to :entry, polymorphic: true


  # Validations
  validates :source, presence: true
  validates :entry,  presence: true


  # Helpers
  def cite
    type   = { website: 'webpage', book: 'book', document: 'entry', photo: 'graphic' }[source.kind.to_sym]
    params = { type: type, title: source.name, accessed: created_at }

    params[:issued] = source.date_created if     source.date_created
    params[:author] = source.authors      unless source.authors.empty?
    params[:URL]    = source.identifier   if     source.kind == 'website'
    params[:isbn]   = source.identifier   if     source.kind == 'book'
    params[:note]   = content             unless content.empty?

    CiteProc::Item.create!(*[params])
  end
end
