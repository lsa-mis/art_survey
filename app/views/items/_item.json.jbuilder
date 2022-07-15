json.extract! item, :id, :description, :location_building, :location_room, :value_cost, :date_acquired, :department_contact, :updated_by, :archived, :appraisal_type_id, :department_id, :created_at, :updated_at
json.url item_url(item, format: :json)
