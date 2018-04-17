class Admin::PagesController < ApplicationController
  def dashboard
    authorize [:admin, :pages], :dashboard?
    render 'admin/dashboard'
  end
end
