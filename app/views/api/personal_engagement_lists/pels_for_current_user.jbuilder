json.array! @pels do |pel|
  json.(pel, :id, :created_at)
  json.questions pel.questions, :body, :priority, :score, :comments
end
