class AddPaymentAttributesToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :status, :string, :null => false, :default => Attendee::STATUS[:new]
    add_column :attendees, :paypal_token, :string
    add_column :attendees, :paypal_amount, :integer
    add_column :attendees, :paypal_success, :boolean
    add_column :attendees, :paypal_authorization, :string
    add_column :attendees, :paypal_message, :string
    add_column :attendees, :paypal_params, :text
  end

  def self.down
    remove_column :attendees, :status
    remove_column :attendees, :paypal_token
    remove_column :attendees, :paypal_amount
    remove_column :attendees, :paypal_success
    remove_column :attendees, :paypal_authorization
    remove_column :attendees, :paypal_message
    remove_column :attendees, :paypal_params
  end
end
