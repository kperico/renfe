class AlertMailer < ActionMailer::Base
  default from: "pablo.molinacandel@gmail.com"

  def notify(alert)
    @alert = alert

    mail to: @alert.recipients,
         bcc: "pablo.molinacandel@gmail.com",
         subject: "¡Tachán! Ya hay trenes disponibles"
  end

  def new(alert)
    @alert = alert

    mail to: 'pablo.molinacandel@gmail.com', subject: "nueva alertica :)"
  end

  def created(alert)
    @alert = alert

    mail to: @alert.recipients, subject: "¡Al loro! Otra alerta eh"
  end
end
