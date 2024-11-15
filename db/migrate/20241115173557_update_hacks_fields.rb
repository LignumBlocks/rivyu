class UpdateHacksFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :hacks, :title, :string
    remove_column :hacks, :free_description, :text
    remove_column :hacks, :premium_description, :text
    remove_column :hacks, :extended_title, :string

    add_column :hacks, :init_title, :string
    add_column :hacks, :free_title, :string
    add_column :hacks, :premium_title, :string
    add_column :hacks, :description, :text
  end
end
