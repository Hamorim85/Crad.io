class ContactMailer < ApplicationMailer
  default from: 'contact@crad.io'
  default to: 'contact@crad.io'

 def sendcontact(name, email, website, country, subject, message)
    @name = name
    @email = email
    @website = website
    @country = country
    @subject = subject
    @message = message
    mail( subject: "contact form of crad.io")
  end

end
