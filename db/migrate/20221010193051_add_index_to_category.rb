class AddIndexToCategory < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :slug, unique: true
  end
end
