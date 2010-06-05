class Workshop < ActiveRecord::Base
  has_many :attendees, :dependent => :destroy
  before_create :create_permalink
  
  def create_permalink
    self.permalink = self.title.parameterize
  end
  
  def to_param
    self.permalink
  end

end
