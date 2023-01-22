class AddStripeAccountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stripe_account_id, :string
    add_column :users, :stripe_account_active, :boolean, default: false
  end
end
