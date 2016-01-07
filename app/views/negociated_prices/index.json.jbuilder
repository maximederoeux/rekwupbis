json.array!(@negociated_prices) do |negociated_price|
  json.extract! negociated_price, :id, :article_id, :client_id, :washing_price, :handwash_price, :tab_price, :deposit_price
  json.url negociated_price_url(negociated_price, format: :json)
end
