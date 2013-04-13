class Alert < ActiveRecord::Base
  attr_accessible :from, :name, :recipients, :sent, :to, :when

  validates :from, :recipients, :to, :when, presence: true
end
