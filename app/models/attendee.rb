class Attendee < ActiveRecord::Base
  belongs_to :workshop
  
  validates_presence_of :name, :email, :phone
  validates_format_of :email, :with => RubyRegex::Email
  validates_format_of :phone, :with => /.{9,}/
  
  serialize :paypal_params
  
  STATUS = {
    :new => 'new',
    :paid => 'paid',
    :error => 'error'
  }
  
  def parse_paypal_response( paypal_response )
    begin
      self.paypal_success       = paypal_response.success?
      self.paypal_authorization = paypal_response.authorization
      self.paypal_message       = paypal_response.message
      self.paypal_params        = paypal_response.params
    rescue ActiveMerchant::ActiveMerchantError => e
      self.paypal_success       = false
      self.paypal_authorization = nil
      self.paypal_message       = e.message
      self.paypal_params        = {}
    end
    self.save
  end
  
  def mark_as_purchased
    self.update_attributes(:status => Attendee::STATUS[:paid])
    AppMailer.deliver_attendee_enrolled_admin( self )
    AppMailer.deliver_attendee_enrolled_attendee( self )
  end
end
