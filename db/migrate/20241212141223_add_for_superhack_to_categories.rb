class AddForSuperhackToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :for_super_hacks, :boolean, default: false
  end
end
