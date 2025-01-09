json.extract! customer_table, :id, :created_at, :updated_at
json.url customer_table_url(customer_table, format: :json)
