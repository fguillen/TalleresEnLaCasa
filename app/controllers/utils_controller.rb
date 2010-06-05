class UtilsController < ApplicationController
  def raise_exception
    raise Exception.new( "Error wadus" )
  end
end