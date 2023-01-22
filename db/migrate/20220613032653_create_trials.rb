class CreateTrials < ActiveRecord::Migration[6.1]
  def change
    create_table :trials do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :image

      t.timestamps
    end
  end
end
