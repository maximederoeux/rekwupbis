json.array!(@offers) do |offer|
  json.extract! offer, :id, :event_id, :organizer_id
  json.url offer_url(offer, format: :json)
end
