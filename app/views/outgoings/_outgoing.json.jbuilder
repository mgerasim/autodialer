json.extract! outgoing, :id, :telephone, :created_at, :updated_at
json.url outgoing_url(outgoing, format: :json)
