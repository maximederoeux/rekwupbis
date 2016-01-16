json.array!(@return_details) do |return_detail|
  json.extract! return_detail, :id, :return_box_id, :box_id, :dirty, :sealed, :clean
  json.url return_detail_url(return_detail, format: :json)
end
