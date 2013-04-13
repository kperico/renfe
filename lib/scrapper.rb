require 'mechanize'

module Scrapper
  include Sidekiq::Worker

  def perform
    a = Mechanize.new
    a.user_agent_alias = 'Mac Mozilla'
    a.verify_mode = OpenSSL::SSL::VERIFY_NONE

    a.get 'http://www.renfe.com/'

    Alert.where(sent: false).each do |alert|
      code_from = Station.where(name: alert.from).first.code
      code_to = Station.where(name: alert.to).first.code
      request_params = "tipoBusqueda=autocomplete&desOrigen=#{CGI.escape(alert.from)}&desDestino=#{CGI.escape(alert.to)}&ninos=0&currenLocation=menuBusqueda&operation=&grupos=false&tipoOperacion=IND&empresas=false&HoraIdaSel=00%3A00&HoraVueltaSel=00%3A00&cdgoOrigen=#{CGI.escape(code_from)}&cdgoDestino=#{CGI.escape(code_to)}&idiomaBusqueda=ES&vengoderenfecom=SI&iv=i&IdOrigen=#{CGI.escape(alert.from)}&IdDestino=#{CGI.escape(alert.to)}&FechaIdaSel=#{CGI.escape(alert.when.strftime('%d/%m/%Y'))}&FechaVueltaSel=&adultos=1"
      #"tipoBusqueda=autocomplete&desOrigen=Madrid+%28*%29&desDestino=Cadiz&ninos=0&currenLocation=menuBusqueda&operation=&grupos=false&tipoOperacion=IND&empresas=false&HoraIdaSel=00%3A00&HoraVueltaSel=00%3A00&cdgoOrigen=MADRI&cdgoDestino=51405&idiomaBusqueda=ES&vengoderenfecom=SI&iv=i&IdOrigen=#{alert.from}&IdDestino=#{alert.to}&FechaIdaSel=#{alert.when.strftime('%d/%m/%Y')}&FechaVueltaSel=&adultos=1",
      result = a.post('https://venta.renfe.com/vol/buscarTren.do',
                      request_params,
                      'Referer' => 'http://www.renfe.com/',
                      'Content-Type' => 'application/x-www-form-urlencoded')

      doc = result.parser
      trains = doc.css("[name='trenIda_radio']").length > 0

      AlertMailer.notify(alert).deliver if trains
      alert.update_attribute(:sent, true)
    end

  end
end

