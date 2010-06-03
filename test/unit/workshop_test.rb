require 'test_helper'

class WorkshopTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Workshop.new.valid?
  end
end
