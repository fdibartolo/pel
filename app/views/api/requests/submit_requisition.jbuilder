if @errors.any?
  json.errors @errors
else
  json.requisition_id @requisition.id
end