json.extract! annotation, :id, :note, :updated_by, :art_item_id, :created_at, :updated_at
json.url annotation_url(annotation, format: :json)
json.note annotation.note.to_s
