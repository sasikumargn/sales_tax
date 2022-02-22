class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :quantity
      t.string :description
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.references :cart

      t.timestamps
    end
  end
end
