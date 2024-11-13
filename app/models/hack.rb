class Hack < ApplicationRecord
  belongs_to :article
  has_and_belongs_to_many :categories, join_table: :hack_categories
end
