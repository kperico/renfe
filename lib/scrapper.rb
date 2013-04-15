require 'mechanize'

class Scrapper
  include Sidekiq::Worker

  def perform
    Alert.where(sent: false).all.each.hit_web do |alert|
      AlertMailer.notify(alert).deliver
      alert.update_attribute(:sent, true)
    end
  end

end

