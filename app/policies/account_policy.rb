class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    # need to change
    true
  end

  def destroy?
    # need to change
    true
    # user == record.user.id
  end
end
