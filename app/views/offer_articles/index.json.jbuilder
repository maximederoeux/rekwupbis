json.array!(@offer_articles) do |offer_article|
  json.extract! offer_article, :id, :offer_id, :article_id, :quantity
  json.url offer_article_url(offer_article, format: :json)
end
