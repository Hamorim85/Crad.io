class Admin::InfluencerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    person.is_a?(Admin)
  end
end
