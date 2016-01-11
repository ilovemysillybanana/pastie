json.array!(@comments) do |comment|
  json.extract! comment, :id, :author, :content
  json.url comment_url(comment, format: :json)
end
