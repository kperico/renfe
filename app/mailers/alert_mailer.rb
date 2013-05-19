class AlertMailer < ActionMailer::Base
  default from: "pablo.molinacandel@gmail.com"

  def notify(alert)
    @alert = alert

    mail to: @alert.recipients,
         bcc: "pablo.molinacandel@gmail.com",
         subject: "¡Tachán! Ya hay trenes disponibles"
  end

  def created(alert)
    @alert = alert

    mail to: @alert.recipients,
         bcc: "pablo.molinacandel@gmail.com",
         subject: "¡Al loro! Otra alerta eh"
  end
end
