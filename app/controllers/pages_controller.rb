class PagesController < ApplicationController
  skip_before_action :authenticate_person!

  def home; end
  def contact; end

  def sendcontact
    name = params['name']
    email = params['email']
    website = params['website']
    country = params['country']
    subject = params['subject']
    message = params['message']
    ContactMailer.sendcontact(name, email, website, country, subject, message).deliver_now
  end

end
