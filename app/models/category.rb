class Category < ApplicationRecord
  belongs_to :classification
  has_many :hack_categories
  has_many :hacks, through: :hack_categories
  has_many :superhack_categories
  has_many :superhacks, through: :superhack_categories

  scope :popularity_categories, -> { where(classification_id: Classification.find_by_name('Popularity').id) }
  scope :financial_topic_categories, lambda {
    where(classification_id: Classification.find_by_name('Specific Financial Topic').id)
  }
  scope :audience_categories, -> { where(classification_id: Classification.find_by_name('Audience and Life Stage').id) }
  scope :horizon_categories, -> { where(classification_id: Classification.find_by_name('Time Horizon').id) }
  scope :risk_categories, -> { where(classification_id: Classification.find_by_name('Risk Level').id) }
  scope :implementation_categories, lambda {
    where(classification_id: Classification.find_by_name('Implementation Difficulty').id)
  }
  scope :financial_categories, -> { where(classification_id: Classification.find_by_name('Financial Goals').id) }
  scope :knowledge_categories, lambda {
    where(classification_id: Classification.find_by_name('Knowledge Level Required').id)
  }
  scope :scale_categories, -> { where(classification_id: Classification.find_by_name('Complexity Scale').id) }
end
