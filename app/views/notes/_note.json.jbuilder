json.extract! note, :id, :content, :references, :created_at, :updated_at
json.url note_url(note, format: :json)