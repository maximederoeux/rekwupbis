json.array!(@prices) do |price|
  json.extract! price, :id, :article_id, :user_id, :wash, :handwash, :handling, :deposit, :regular, :negociated, :valid_from, :valid_till, :sell
  json.url price_url(price, format: :json)
end
