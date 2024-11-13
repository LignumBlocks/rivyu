class HackCategory < ApplicationRecord
  belongs_to :category
  belongs_to :hack
end
