# -*- coding: utf-8 -*-
class CreateMeters < ActiveRecord::Migration
  def change
    create_table :meters do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end
    
    meters = [["不明もしくは指定なし", 0],
              ["0～1,000km", 1],
              ["1,001～5,000km", 2],
              ["5,001～10,000km", 3],
              ["10,001～15,000km", 4],
              ["15,001～20,000km", 5],
              ["20,001～30,000km", 6],
              ["30,001～40,000km", 7],
              ["40,001～50,000km", 8],
              ["50,001km～", 9]]

    meters.each do |m|
      Meter.create(name: m[0], key: m[1])
    end
  end
end
