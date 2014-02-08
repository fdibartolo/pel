json.array! @requests do |request|
  json.(request, :id, :created_at, :message)
  json.owner request.owner.enterprise_id
  json.requisition_id request.requisition_for(current_user).id
  json.requisition_pel_id request.requisition_for(current_user).personal_engagement_list_id
end
