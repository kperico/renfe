class Station < ActiveRecord::Base
  attr_accessible :name, :code

  def self.list
    @stations ||= Station.pluck(:name)
  end
end
