class SubmissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:exam).where(exam: { user_id: user.id })
      end
    end
  end

  def show?
    update?
  end

  def update?
    user.id == record.user_id
  end
end