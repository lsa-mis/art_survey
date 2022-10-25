json.extract! page_information, :id, :location, :content, :created_at, :updated_at
json.url page_information_url(page_information, format: :json)
json.content page_information.content.to_s
