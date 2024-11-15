class AddFieldsToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :are_hacks, :boolean
    add_column :articles, :justification, :text
    add_column :articles, :content_summary, :text
  end
end
