json.array!(@energies) do |energy|
  json.extract! energy, :id, :water, :gaz, :electricity
  json.url energy_url(energy, format: :json)
end
