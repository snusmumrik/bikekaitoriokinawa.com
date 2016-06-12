# -*- coding: utf-8 -*-
require "headless"
require "selenium-webdriver"

class Price < ActiveRecord::Base
  belongs_to :model
  belongs_to :meter

  def self.get_prices
    headless = Headless.new
    headless.start

    Maker.all.each do |maker|
      p maker.name
      Engine.all.each do |engine|
        p "#{maker.name} #{engine.name}"
        # bikes = driver.find_elements(:xpath, "//select[@name='family']/option")
        Bike.where(["maker_id = ? AND engine_id = ?", maker.id, engine.id]).all.each do |bike|
          p "#{maker.name} #{engine.name} #{bike.name}"
          next if bike.id <= 541

          unless bike.name == "車種をお選びください"
            /H([0-9]+)/ =~ Date.today.jisx0301
            wareki = $1.to_i
            model_years = ["不明もしくは指定なし"]
            for i in 1..wareki
              model_years << i.to_s
            end

            model_year_not_found = nil

            model_years.each do |model_year|
              break if model_year_not_found

              p "#{maker.name} #{engine.name} #{bike.name} #{model_year}"
              Meter.all.each do |meter|
                break if model_year_not_found
                p "#{maker.name} #{engine.name} #{bike.name} #{model_year} #{meter.name}"

                begin
                  driver = Selenium::WebDriver.for :chrome
                  driver.navigate.to("http://www.bikeone.jp")

                  driver.find_element(:xpath, "//select[@name='maker']/option[@value='#{maker.key}']").click()
                  driver.find_element(:xpath, "//select[@name='engine']/option[@value='#{engine.key}']").click()
                  driver.find_element(:xpath, "//select[@name='family']").click()
                  driver.find_element(:xpath, "//select[@name='engine']").click()

                  sleep(3)

                  driver.find_element(:xpath, "//select[@name='family']/option[@value='#{bike.name}']").click()
                  driver.find_element(:xpath, "//select[@name='model_year']").click()
                  driver.find_element(:xpath, "//select[@name='family']").click()

                  sleep(3)

                  driver.find_element(:xpath, "//select[@name='model_year']/option[@value='#{model_year}']").click() unless model_year == "不明もしくは指定なし"

                  driver.find_element(:xpath, "//select[@name='meter']/option[@value='#{meter.key}']").click()

                  driver.find_element(:name, "btn").click()

                  spans = driver.find_elements(:xpath, "//div[@class='textll']/span")
                  high = ""
                  average = ""
                  spans.each_with_index do |span, i|
                    price = span.text.gsub(/¥ |,/, "")
                    case i
                    when 0
                      high = price
                    when 1
                      average = price
                    end
                  end
                  bike_id = Bike.where(["name = ?", bike.name]).first.try(:id)
                  p "bike_id: #{bike_id}, year: #{model_year}, meter_id: #{meter.id}, high: #{high}, average: #{average}"
                  if price_model = Price.where(["bike_id = ? AND year = ? AND meter_id = ?", bike_id, model_year, meter.id]).first
                    price_model.update_attributes(high: high, average: average)
                  else
                    Price.create(bike_id: bike_id, year: model_year, meter_id: meter.id, high: high, average: average)
                  end
                rescue => ex
                  p ex.message
                  model_year_not_found = true
                end
                driver.quit
              end
            end
          end
        end
      end
    end

    driver.quit
    headless.destroy
  end
end
