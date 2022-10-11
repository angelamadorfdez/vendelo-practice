class AddNullFalseToCategoryFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :categories, :name, false
    change_column_null :categories, :slug, false
  end
end
