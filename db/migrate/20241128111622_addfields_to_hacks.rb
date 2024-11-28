class AddfieldsToHacks < ActiveRecord::Migration[7.0]
  def change
    add_column :hacks, :synchronized, :boolean, default: false
    add_column :hacks, :completed, :boolean, default: false
  end
end
