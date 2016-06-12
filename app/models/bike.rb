# -*- coding: utf-8 -*-
require "headless"
require "selenium-webdriver"

class Bike < ActiveRecord::Base
  belongs_to :maker
  belongs_to :engine

  validates :name, uniqueness: true

  def self.get_bikes
    def self.scrape
      headless = Headless.new
      headless.start
      driver = Selenium::WebDriver.for :chrome
      
      url = "http://www.bikeone.jp"
      
      Maker.all.each do |maker|
        Engine.all.each do |engine|
          driver.navigate.to(url)
          
          driver.find_element(:xpath, "//select[@name='maker']/option[@value='#{maker.key}']").click()
          driver.find_element(:xpath, "//select[@name='engine']/option[@value='#{engine.key}']").click()
          
          sleep(10)
          bikes = driver.find_elements(:xpath, "//select[@name='family']/option")
          bikes.each do |bike|
            Bike.create(maker_id: maker.id, engine_id: engine.id, name: bike.text) unless bike.text == "車種をお選びください"
          end
        end
      end
      
      driver.quit
      headless.destroy
    end
  end
end
