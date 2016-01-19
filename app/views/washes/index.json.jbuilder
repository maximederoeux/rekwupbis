json.array!(@washes) do |wash|
  json.extract! wash, :id, :return_box_id, :start_time, :end_time, :washer
  json.url wash_url(wash, format: :json)
end
