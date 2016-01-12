json.array!(@deliveries) do |delivery|
  json.extract! delivery, :id, :order_id, :delivery_date, :return_date
  json.url delivery_url(delivery, format: :json)
end
