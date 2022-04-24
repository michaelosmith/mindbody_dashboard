class AddTokenLastUsedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token_last_used, :datetime
  end
end
