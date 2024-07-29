class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailers.default_mail
  layout "mailer"
end
