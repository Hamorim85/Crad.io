class Admin::PagesController < ApplicationController
  skip_before_action :authenticate_admin!, :authenticate_brand!

  def dashboard
    render 'admin/dashboard'
  end
end
