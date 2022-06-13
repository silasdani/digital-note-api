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
    record.exam.user_id == user.id
  end
end