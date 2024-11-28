class CreateHackValidationSuperhacks < ActiveRecord::Migration[7.0]
  def change
    create_table :hack_validation_superhacks do |t|
      t.integer :id_hack_compared_first
      t.integer :id_hack_compared_second
      t.boolean :has_superhack

      t.timestamps
    end
  end
end
