class SetCategorySlugAsUnique < ActiveRecord::Migration[7.0]
  def change
    change_column :categories, :slug, :string, unique: true
  end
end
