class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :currency_type

      t.timestamps
    end
  end
end
