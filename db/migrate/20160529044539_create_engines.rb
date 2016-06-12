# -*- coding: utf-8 -*-
class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end

    engines = [["～50", "0-50"], 
               ["51～125", "51-125"],
               ["126～250", "126-250"],
               ["251～400", "251-400"],
               ["401～750", "401-750"],
               ["751～", "751-1000000"]]

    engines.each do |e|
      Engine.create(name: e[0], key: e[1])
    end
  end
end
