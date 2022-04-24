class ChangeNameTokenLastUsed < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :token_last_used, :token_last_used_at
  end
end
