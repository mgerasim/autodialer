json.extract! configuration, :id, :password_encrypted, :is_outgoing_deleted, :is_outgoing_table_showed, :is_google_integrated, :is_attempt_supported, :is_answer_supported, :created_at, :updated_at
json.url configuration_url(configuration, format: :json)
