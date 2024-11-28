class Hack < ApplicationRecord
  belongs_to :article
  has_one :source, through: :article
  has_many :hack_categories
  has_many :categories, through: :hack_categories
  has_many :superhack_sources
  has_many :superhacks, through: :superhack_sources
end
