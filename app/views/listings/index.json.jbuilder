json.array!(@listings) do |listing|
  json.extract! listing, :id#, :name, :code, :language
  json.value listing.name
  json.tokens listing.name_tokens
  json.url listing_url(listing, format: :json)
end
