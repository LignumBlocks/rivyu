class Category < ApplicationRecord
  belongs_to :classification
  has_many :hack_categories
  has_many :hacks, through: :hack_categories
  has_many :superhack_categories
  has_many :superhacks, through: :superhack_categories

  scope :for_hacks, -> { where(for_super_hacks: false) }
  scope :for_super_hacks, -> { where(for_super_hacks: true) }

  scope :popularity_categories, -> {
    where(classification_id: Classification.where(name: 'Popularity').pluck(:id))
  }

  scope :financial_topic_categories, -> {
    where(classification_id: Classification.where(name: 'Specific Financial Topic').pluck(:id))
  }

  scope :audience_categories, -> {
    where(classification_id: Classification.where(name: 'Audience and Life Stage').pluck(:id))
  }

  scope :horizon_categories, -> {
    where(classification_id: Classification.where(name: 'Time Horizon').pluck(:id))
  }

  scope :risk_categories, -> {
    where(classification_id: Classification.where(name: 'Risk Level').pluck(:id))
  }

  scope :implementation_categories, -> {
    where(classification_id: Classification.where(name: 'Implementation Difficulty').pluck(:id))
  }

  scope :financial_categories, -> {
    where(classification_id: Classification.where(name: 'Financial Goals').pluck(:id))
  }

  scope :knowledge_categories, -> {
    where(classification_id: Classification.where(name: 'Knowledge Level Required').pluck(:id))
  }

  scope :scale_categories, -> {
    where(classification_id: Classification.where(name: 'Complexity Scale').pluck(:id))
  }
end
