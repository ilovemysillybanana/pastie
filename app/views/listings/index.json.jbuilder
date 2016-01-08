json.array!(@listings) do |listing|
  json.extract! listing, :id, :name, :code, :language
  json.url listing_url(listing, format: :json)
end
