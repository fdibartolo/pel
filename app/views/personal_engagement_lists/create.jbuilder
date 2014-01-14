if @errors.any?
  json.errors @errors
#  json.response do |json|
#    json.status 422
#  end
else
  json.(@pel, :id, :created_at)
  json.questions @pel.questions, :body, :priority, :score, :comments
end