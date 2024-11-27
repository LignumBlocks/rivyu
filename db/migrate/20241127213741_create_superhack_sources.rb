class CreateSuperhackSources < ActiveRecord::Migration[7.0]
  def change
    create_table :superhack_sources do |t|
      t.references :superhack, null: false, foreign_key: true
      t.references :hack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
