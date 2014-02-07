class AddEstimatedPriceToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :estimated_price, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
