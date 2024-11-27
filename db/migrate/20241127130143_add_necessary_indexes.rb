class AddNecessaryIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :hack_categories, %i[hack_id category_id]
    add_index :categories, %i[classification_id name]
    add_index :hacks, :is_advice
    add_index :hacks, :main_goal
    add_index :hacks, :description
  end
end
