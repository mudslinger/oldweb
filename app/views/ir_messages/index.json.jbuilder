json.array!(@ir_messages) do |ir_message|
  json.extract! ir_message, 
  json.url ir_message_url(ir_message, format: :json)
end
