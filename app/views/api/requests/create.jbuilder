if @request.errors.any?
  json.errors @errors
else
  json.valid_recipients @request.recipients.map(&:enterprise_id)
  json.invalid_recipients @invalid_recipients
end