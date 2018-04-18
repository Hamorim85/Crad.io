class MailingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      person.mailings
    end
  end

  def index?
    true
  end

  def create?
    true
  end
end
