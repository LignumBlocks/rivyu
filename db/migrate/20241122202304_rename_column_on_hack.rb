class RenameColumnOnHack < ActiveRecord::Migration[7.0]
  def change
    rename_column :hacks, :is_advise, :is_advice
  end
end
