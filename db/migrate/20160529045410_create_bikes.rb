class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.references :maker, index: true, foreign_key: true
      t.references :engine, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
