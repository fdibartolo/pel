class Ability
  include CanCan::Ability

  def initialize user
    can :manage, PersonalEngagementList do |pel|
      pel.user_id == user.id
    end

    if user.has_role? AdminRole
      can :manage, TemplateQuestion
      can :manage, PersonalEngagementList
    end
  end
end
