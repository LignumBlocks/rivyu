class Hack < ApplicationRecord
  belongs_to :article
  has_one :source, through: :article
  has_many :hack_categories
  has_and_belongs_to_many :categories, through: :hack_categories
  has_and_belongs_to_many :classifications, through: :categories
end
