json.extract! lead, :id, :phone, :dialer_status, :dialer_attempt, :is_offer_accepted, :created_at, :updated_at
json.url lead_url(lead, format: :json)
