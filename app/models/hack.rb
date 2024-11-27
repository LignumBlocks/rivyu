class Hack < ApplicationRecord
  belongs_to :article
  has_one :source, through: :article
  has_many :hack_categories
  has_many :categories, through: :hack_categories

  def self.with_popularity_ids(*ids)
    joins(categories: :hack_categories)
      .merge(Category.popularity_categories.where(id: ids))
      .distinct
  end

  def self.with_financial_topic_ids(*ids)
    joins(categories: :hack_categories).merge(Category.financial_topic_categories.where(id: ids)).distinct
  end

  def self.with_audience_ids(*ids)
    joins(categories: :hack_categories).merge(Category.audience_categories.where(id: ids)).distinct
  end

  def self.with_horizon_ids(*ids)
    joins(categories: :hack_categories).merge(Category.horizon_categories.where(id: ids)).distinct
  end

  def self.with_risk_ids(*ids)
    joins(categories: :hack_categories).merge(Category.risk_categories.where(id: ids)).distinct
  end

  def self.with_implementation_ids(*ids)
    joins(categories: :hack_categories).merge(Category.implementation_categories.where(id: ids)).distinct
  end

  def self.with_financial_ids(*ids)
    joins(categories: :hack_categories).merge(Category.financial_categories.where(id: ids)).distinct
  end

  def self.with_knowledge_ids(*ids)
    joins(categories: :hack_categories).merge(Category.knowledge_categories.where(id: ids)).distinct
  end

  def self.with_scale_ids(*ids)
    joins(categories: :hack_categories).merge(Category.scale_categories.where(id: ids)).distinct
  end

  def self.ransackable_scopes(auth_object = nil)
    %i[ with_popularity_ids with_financial_topic_ids with_audience_ids with_horizon_ids with_risk_ids with_implementation_ids
        with_financial_ids with_knowledge_ids with_scale_ids ]
  end
end
