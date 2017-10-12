class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.string :purchaserName
      t.string :itemDescription
      t.float :itemPrice
      t.integer :purchaseCount
      t.text :merchantAddress
      t.string :merchantName

      t.timestamps
    end
  end
end
