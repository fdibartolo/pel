class Ability
  include CanCan::Ability

  def initialize user
    can :manage, PersonalEngagementList do |pel|
      pel.user_id == user.id
    end

    if user.has_role? RequestorRole
      can :manage, Request do |request|
        request.owner_id == user.id
      end
    end

    if user.has_role? AdminRole
      can :manage, TemplateQuestion
      can :manage, PersonalEngagementList
      can :manage, Request
    end
  end
end
