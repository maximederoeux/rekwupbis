json.array!(@sortings) do |sorting|
  json.extract! sorting, :id, :return_box_id, :start_time, :end_time, :starter, :ender
  json.url sorting_url(sorting, format: :json)
end
