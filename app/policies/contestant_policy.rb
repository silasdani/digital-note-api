class ContestantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      end
    end
  end

  def show?
    update?
  end

  def update?
    Exam.where(user_id: user.id).pluck(:access_key).include? record.access_key
  end
end