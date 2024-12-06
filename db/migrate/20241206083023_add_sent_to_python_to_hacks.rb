class AddSentToPythonToHacks < ActiveRecord::Migration[7.0]
  def change
    add_column :hacks, :sent_to_python, :boolean, default: false
  end
end
