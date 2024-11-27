class Superhack < ApplicationRecord
  has_many :superhack_sources
  has_many :hacks, through: :superhack_sources

  has_many :superhack_categories
  has_many :categories, through: :superhack_categories
end
