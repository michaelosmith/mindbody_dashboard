class AddUsersToMembers < ActiveRecord::Migration[6.1]
  def change
    add_reference :members, :user, :integer, null: false, foreign_key: true
  end
end
