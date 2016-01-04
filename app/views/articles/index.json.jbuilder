json.array!(@articles) do |article|
  json.extract! article, :id, :article_name, :article_content, :article_type, :article_category, :quantity_bigbox, :quantity_smallbox, :quantity_pile
  json.url article_url(article, format: :json)
end
