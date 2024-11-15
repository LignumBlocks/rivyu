class AddMainGoldToHacks < ActiveRecord::Migration[7.0]
  def change
    add_column :hacks, :main_goal, :string
  end
end
