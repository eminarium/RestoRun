class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :title, null: false
      t.text :description
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
