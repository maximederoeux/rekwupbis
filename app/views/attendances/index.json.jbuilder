json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :start_time, :end_time, :user_id
  json.url attendance_url(attendance, format: :json)
end
