json.array!(@sorting_details) do |sorting_detail|
  json.extract! sorting_detail, :id, :sorting_id, :article_id, :box_qtty, :pile_qtty, :unit_qtty, :clean, :very_dirty, :broken, :handling
  json.url sorting_detail_url(sorting_detail, format: :json)
end
