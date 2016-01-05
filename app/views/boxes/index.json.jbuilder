json.array!(@boxes) do |box|
  json.extract! box, :id, :box_name, :box_regular, :box_type
  json.url box_url(box, format: :json)
end
