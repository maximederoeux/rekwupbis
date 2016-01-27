json.array!(@parcels) do |parcel|
  json.extract! parcel, :id, :return_box_id, :box_id, :quantity
  json.url parcel_url(parcel, format: :json)
end
