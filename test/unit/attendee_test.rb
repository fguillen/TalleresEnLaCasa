require 'test_helper'

class AttendeeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Attendee.new.valid?
  end
end
