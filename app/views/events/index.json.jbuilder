json.array!(@events) do |event|
  json.extract! event, :id, :event_name, :event_start_date, :event_end_date, :expected_pax, :last_pax, :post_code, :city, :country, :comment, :cuptwenty, :cuptwentyfive, :cupforty, :cupfifty, :cuplitre, :cupwine, :cupcava, :cupshot
  json.url event_url(event, format: :json)
end
