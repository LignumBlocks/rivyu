class CreateSuperhacks < ActiveRecord::Migration[7.0]
  def change
    create_table :superhacks do |t|
      t.string :title
      t.text :description
      t.text :implementation_steps
      t.text :expected_results
      t.text :risks_and_mitigation

      t.timestamps
    end
  end
end
