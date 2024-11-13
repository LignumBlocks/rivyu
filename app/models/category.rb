class Category < ApplicationRecord
  belongs_to :classification
  has_and_belongs_to_many :hacks, join_table: :hack_categories
end
