json.array!(@comments) do |comment|
  json.extract! comment, :id, :post_id, :text, :date, :nickname
  json.url comment_url(comment, format: :json)
end
