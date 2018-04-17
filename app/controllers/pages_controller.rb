class PagesController < ApplicationController
  skip_before_action :authenticate_admin!, :authenticate_brand!

  def home; end
end
