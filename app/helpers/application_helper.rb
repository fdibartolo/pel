module ApplicationHelper
  def inbox_count
    current_user.requests.count
  end
end
