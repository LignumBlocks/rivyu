class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
