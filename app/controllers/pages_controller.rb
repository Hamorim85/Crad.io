class PagesController < ApplicationController
  skip_before_action :authenticate_person!

  def home; end
end
