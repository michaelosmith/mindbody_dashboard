class MakeSlugNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :slug, :string, null: false
  end
end
