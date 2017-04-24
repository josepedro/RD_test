json.extract! contact, :id, :email, :page_views, :created_at, :updated_at
json.url contact_url(contact, format: :json)
