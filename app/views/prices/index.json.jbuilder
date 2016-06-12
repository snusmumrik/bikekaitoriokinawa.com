json.array!(@prices) do |price|
  json.extract! price, :id, :bike_id, :year, :meter_id, :high, :average
  json.url price_url(price, format: :json)
end
