json.extract! art_item, :id, :description, :location_building, :location_room, :value_cost, :date_acquired, :appraisal_type_id, :appraisal_description, :protection, :archived, :department_id, :updated_by, :department_contact, :annotation_id, :documents, :images, :created_at, :updated_at
json.url art_item_url(art_item, format: :json)
json.description art_item.description.to_s
json.appraisal_description art_item.appraisal_description.to_s
json.protection art_item.protection.to_s
json.documents do
  json.array!(art_item.documents) do |document|
    json.id document.id
    json.url url_for(document)
  end
end
json.images do
  json.array!(art_item.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
