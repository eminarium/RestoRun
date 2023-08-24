class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :is_halal, null: false, default: false
      t.boolean :is_kosher, null: false, default: false
      t.boolean :is_vegetarian, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
