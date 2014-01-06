class PersonalEngagementListsController < ApplicationController
  respond_to :json

  def pels_for_current_user
    #respond_with pels_for current_user  
    # redirct if no current user!!!
    @pels = PersonalEngagementList.where(user_id: current_user.id)
  end

  # def pels_for user
  #   PersonalEngagementList.where(user_id: user.id)    
  # end
end
