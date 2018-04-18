class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # [...]
  devise_group :person, contains: %i[brand admin]
  before_action :authenticate_person! # Ensure someone is logged in

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  alias current_user current_person

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: %i[index home], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit_scope?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
  end

  def user_not_authorized
    flash[:alert] = 'Not authorized'
    redirect_to root_path
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^pages$)/
  end

  def skip_pundit_scope?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
