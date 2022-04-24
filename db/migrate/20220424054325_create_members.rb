class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :mindbody_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.date :birth_date
      t.datetime :profile_created_date
      t.datetime :profile_last_modified_date
      t.string :profile_hash

      t.timestamps
    end
  end
end
