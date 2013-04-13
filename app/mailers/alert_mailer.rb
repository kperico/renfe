class AlertMailer < ActionMailer::Base
  default from: "pablo.molinacandel@gmail.com"

  def notify(alert)
    @alert = alert

    mail to: @alert.recipients, subject: "¡Ya hay trenes disponibles!"
  end
end
