json.array!(@contexts) do |context|
  json.extract! context, :id, :name
  json.url context_url(context, format: :json)
end
