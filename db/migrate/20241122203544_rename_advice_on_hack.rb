class RenameAdviceOnHack < ActiveRecord::Migration[7.0]
  def change
    rename_column :hacks, :advise_justification, :advice_justification
  end
end
