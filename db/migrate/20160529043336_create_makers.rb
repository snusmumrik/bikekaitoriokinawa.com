# -*- coding: utf-8 -*-
class CreateMakers < ActiveRecord::Migration
  def change
    create_table :makers do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end

    makers = [["ＨＯＮＤＡ", "H"],
              ["ＹＡＭＡＨＡ", "Y"],
              ["ＳＵＺＵＫＩ", "S"],
              ["ＫＡＷＡＳＡＫＩ", "K"],
              ["外国産車", "+"],
              ["その他", "-"]]
    makers.each do |m|
      Maker.create(name: m[0], key: m[1])
    end
  end
end
