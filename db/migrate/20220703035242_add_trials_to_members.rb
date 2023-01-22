class AddTrialsToMembers < ActiveRecord::Migration[6.1]
  def change
    add_reference :members, :trial, foreign_key: true
  end
end
