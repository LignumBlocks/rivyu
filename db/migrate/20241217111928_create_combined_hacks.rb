class CreateCombinedHacks < ActiveRecord::Migration[7.0]
  def change
    create_table :combined_hacks do |t|
      t.json :data

      t.timestamps
    end
  end
end
