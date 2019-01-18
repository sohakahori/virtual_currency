json.set! :errors do
  json.status code
  json.message message
  unless full_messages.nil?
    json.set! :full_messages do
      json.array! full_messages
    end
  end
end

