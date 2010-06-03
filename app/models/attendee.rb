class Attendee < ActiveRecord::Base
  belongs_to :workshop
  
  validates_presence_of :name, :email, :phone
end
