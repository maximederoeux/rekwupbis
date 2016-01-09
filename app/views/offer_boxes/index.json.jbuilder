json.array!(@offer_boxes) do |offer_box|
  json.extract! offer_box, :id, :offer_id, :box_id, :quantity
  json.url offer_box_url(offer_box, format: :json)
end
