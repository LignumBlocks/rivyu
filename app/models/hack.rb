class Hack < ApplicationRecord
  belongs_to :article
  has_one :source, through: :article
  has_many :hack_categories
  has_many :categories, through: :hack_categories
  has_many :classifications, through: :categories
  has_many :superhack_sources
  has_many :superhacks, through: :superhack_sources

  scope :synchronized, -> { where(synchronized: true) }
  scope :unsynchronized, -> { where(synchronized: false) }
  scope :completed, -> { where(completed: true) }
  scope :unsent_to_python, -> { where(sent_to_python: false) }
end
