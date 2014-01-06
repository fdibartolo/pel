class PersonalEngagementListsController < ApplicationController
  respond_to :json

  def pels_for_current_user
    @pels = PersonalEngagementList.where(user_id: current_user.id)
  end
end
