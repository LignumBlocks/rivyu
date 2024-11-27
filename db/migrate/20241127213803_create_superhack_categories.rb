class CreateSuperhackCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :superhack_categories do |t|
      t.references :superhack, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.text :justification

      t.timestamps
    end
  end
end
