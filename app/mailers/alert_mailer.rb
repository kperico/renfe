class AlertMailer < ActionMailer::Base
  default from: "pablo.molinacandel@gmail.com"

  def notify(alert)
    @alert = alert

    mail to: @alert.recipients, subject: "¡Ya hay trenes disponibles!"
  end

  def new(alert)
    @alert = alert

    mail to: 'pablo.molinacandel@gmail.com', subject: "nueva alertica :)"
  end

  def created(alert)
    @alert = alert

    mail to: @alert.recipients, subject: "Nueva alerta"
  end
end
