class AccountUpdatePolicy < ApplicationPolicy
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
    user == record.user_id
  end

  def destroy?
    # need to fix
    true
  end
end
