class RenameLowToAverage < ActiveRecord::Migration
  def change
    rename_column :prices, :low, :average
  end
end
