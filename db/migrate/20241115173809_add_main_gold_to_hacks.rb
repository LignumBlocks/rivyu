class AddMainGoldToHacks < ActiveRecord::Migration[7.0]
  def change
    add_column :hacks, :main_gold, :string
  end
end
