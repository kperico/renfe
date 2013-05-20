class Alert < ActiveRecord::Base
  attr_accessible :from, :name, :recipients, :sent, :to, :when
  serialize :times, Array

  validates :from, :recipients, :to, :when, presence: true
  
  def hit_web
    a = Mechanize.new
    a.user_agent_alias = 'Mac Mozilla'
    a.verify_mode = OpenSSL::SSL::VERIFY_NONE

    a.get 'http://www.renfe.com/'

    code_from = Station.where(name: self.from).first.code
    code_to = Station.where(name: self.to).first.code
    request_params = "tipoBusqueda=autocomplete&desOrigen=#{CGI.escape(self.from)}&desDestino=#{CGI.escape(self.to)}&ninos=0&currenLocation=menuBusqueda&operation=&grupos=false&tipoOperacion=IND&empresas=false&HoraIdaSel=00%3A00&HoraVueltaSel=00%3A00&cdgoOrigen=#{CGI.escape(code_from)}&cdgoDestino=#{CGI.escape(code_to)}&idiomaBusqueda=ES&vengoderenfecom=SI&iv=i&IdOrigen=#{CGI.escape(self.from)}&IdDestino=#{CGI.escape(self.to)}&FechaIdaSel=#{CGI.escape(self.when.strftime('%d/%m/%Y'))}&FechaVueltaSel=&adultos=1"
    #"tipoBusqueda=autocomplete&desOrigen=Madrid+%28*%29&desDestino=Cadiz&ninos=0&currenLocation=menuBusqueda&operation=&grupos=false&tipoOperacion=IND&empresas=false&HoraIdaSel=00%3A00&HoraVueltaSel=00%3A00&cdgoOrigen=MADRI&cdgoDestino=51405&idiomaBusqueda=ES&vengoderenfecom=SI&iv=i&IdOrigen=#{self.from}&IdDestino=#{self.to}&FechaIdaSel=#{self.when.strftime('%d/%m/%Y')}&FechaVueltaSel=&adultos=1",
    result = a.post('https://venta.renfe.com/vol/buscarTren.do',
                    request_params,
                    'Referer' => 'http://www.renfe.com/',
                    'Content-Type' => 'application/x-www-form-urlencoded')

    doc = result.parser
    rows = doc.css('tr')
    times = []
    rows.each do |row|
      leaves_at = row.xpath('td[2]')
      if leaves_at.present? && leaves_at.attr('headers').try(:value).try(:strip) == 'Salida'
        times << leaves_at.text.strip
      end
    end

    if times.present? && times.length > self.matches
      self.matches = times.length
      self.times = times
      self.save

      yield self if block_given?
      return times.present?
    elsif times.length == 0 && doc.css("[name='trenIda_radio']").length > 0
      raise 'Hay resultados y no se procesaron horarios?'
    end
  rescue Net::HTTP::Persistent::Error => e
    logger.error e.backtrace
  end
end
