if @errors.any?
  json.errors @errors
else
  json.(@pel, :id, :created_at)
  json.questions @pel.questions, :body, :priority, :score, :comments
end
