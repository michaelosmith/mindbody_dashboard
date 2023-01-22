class AddTrialsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :trials, :user, foreign_key: true
  end
end
