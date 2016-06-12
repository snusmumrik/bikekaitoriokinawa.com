class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :bike, index: true, foreign_key: true
      t.string :year
      t.references :meter, index: true, foreign_key: true
      t.integer :high
      t.integer :low

      t.timestamps null: false
    end
  end
end
