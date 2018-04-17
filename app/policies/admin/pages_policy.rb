class Admin::PagesPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def dashboard?
    person.is_a?(Admin)
  end
end
