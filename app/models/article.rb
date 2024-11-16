class Article < ApplicationRecord
  belongs_to :source
  has_many :hacks
end
