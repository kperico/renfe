require 'mechanize'

class Scrapper
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Alert.where(sent: false).each do |alert|
      alert.hit_web do |a|
        AlertMailer.notify(a).deliver
        a.update_attribute(:sent, true)
      end
    end
  end

end

