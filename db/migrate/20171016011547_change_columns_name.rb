class ChangeColumnsName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :purchases, :purchaserName, :purchaser_name
  	rename_column :purchases, :itemDescription, :item_description
  	rename_column :purchases, :itemPrice, :item_price
  	rename_column :purchases, :purchaseCount, :purchase_count
  	rename_column :purchases, :merchantAddress, :merchant_address
  	rename_column :purchases, :merchantName, :merchant_name
  end
end
