class Hack < ApplicationRecord
  belongs_to :article
  has_one :source, through: :article
  has_many :hack_categories
  has_many :categories, through: :hack_categories

  def self.with_popularity(id)
    joins(categories: :hack_categories).merge(Category.popularity_categories.where(id: id)).distinct
  end

  def self.with_financial_topic(id)
    joins(categories: :hack_categories).merge(Category.financial_topic_categories.where(id: id)).distinct
  end

  def self.with_audience(id)
    joins(categories: :hack_categories).merge(Category.audience_categories.where(id: id)).distinct
  end

  def self.with_horizon(id)
    joins(categories: :hack_categories).merge(Category.horizon_categories.where(id: id)).distinct
  end

  def self.with_risk(id)
    joins(categories: :hack_categories).merge(Category.risk_categories.where(id: id)).distinct
  end

  def self.with_implementation(id)
    joins(categories: :hack_categories).merge(Category.implementation_categories.where(id: id)).distinct
  end

  def self.with_financial(id)
    joins(categories: :hack_categories).merge(Category.financial_categories.where(id: id)).distinct
  end

  def self.with_knowledge(id)
    joins(categories: :hack_categories).merge(Category.knowledge_categories.where(id: id)).distinct
  end

  def self.ransackable_scopes(auth_object = nil)
    %i[ with_popularity with_financial_topic with_audience with_horizon with_risk with_implementation with_financial with_knowledge ]
  end
end
