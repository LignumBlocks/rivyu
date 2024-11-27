class Hack < ApplicationRecord
  belongs_to :article
  has_one :source, through: :article
  has_many :hack_categories
  has_many :categories, through: :hack_categories

  has_many :superhack_sources
  has_many :superhacks, through: :superhack_sources

  def self.with_popularity_ids(*ids)
    popular_category_ids = Category.popularity_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: popular_category_ids }).distinct
  end

  def self.with_financial_topic_ids(*ids)
    financial_topic_category_ids = Category.financial_topic_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: financial_topic_category_ids }).distinct
  end

  def self.with_audience_ids(*ids)
    audience_category_ids = Category.audience_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: audience_category_ids }).distinct
  end

  def self.with_horizon_ids(*ids)
    horizon_category_ids = Category.horizon_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: horizon_category_ids }).distinct
  end

  def self.with_risk_ids(*ids)
    risk_category_ids = Category.risk_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: risk_category_ids }).distinct
  end

  def self.with_implementation_ids(*ids)
    implementation_category_ids = Category.implementation_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: implementation_category_ids }).distinct
  end

  def self.with_financial_ids(*ids)
    financial_category_ids = Category.financial_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: financial_category_ids }).distinct
  end

  def self.with_knowledge_ids(*ids)
    knowledge_category_ids = Category.knowledge_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: knowledge_category_ids }).distinct
  end

  def self.with_scale_ids(*ids)
    scale_category_ids = Category.scale_categories.where(id: ids).select(:id)
    joins(:hack_categories).where(hack_categories: { category_id: scale_category_ids }).distinct
  end

  def self.ransackable_scopes(auth_object = nil)
    %i[ with_popularity_ids with_financial_topic_ids with_audience_ids with_horizon_ids with_risk_ids with_implementation_ids
        with_financial_ids with_knowledge_ids with_scale_ids ]
  end
end
