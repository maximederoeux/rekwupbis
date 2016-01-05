json.array!(@boxdetails) do |boxdetail|
  json.extract! boxdetail, :id, :box_id, :article_id, :box_article_quantity
  json.url boxdetail_url(boxdetail, format: :json)
end
